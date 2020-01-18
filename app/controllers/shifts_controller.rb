class ShiftsController < ApplicationController
before_action :authenticate_user!

def index
  @search = Shift.search(params[:q])
  @search.sorts = 'date asc' if @search.sorts.empty?
  @shifts = @search.result.page(params[:page]).per_page(10)
end

def show
  @shift = Shift.find(params[:id])
end

def new
  @shift = Shift.new
end

def edit
  @shift = Shift.find(params[:id])
end

def create
  @shift = Shift.new(shift_params)

  if @shift.save
    redirect_to @shift
  else
    render 'new'
  end
end

def update
  @shift = Shift.find(params[:id])
  if !current_user.admin?
    add_request
  end

  @shift.update(shift_params)
  volunteer_one = @shift[:volunteer]
  volunteer_two = @shift[:volunteer_two]
  @shift.request_by.delete(volunteer_one) if @shift.request_by.include?(volunteer_one)
  @shift.request_by.delete(volunteer_two) if @shift.request_by.include?(volunteer_two)
  @shift.request_by.clear if @shift.status =="assigned"

  if @shift.update(shift_params)
    if @shift[:status] == "assigned"
      ShiftMailer.shift_assigned_email(@shift).deliver_now
    elsif @shift[:status] == "requested"
      ShiftMailer.shift_requested_email(@shift).deliver_now
    end
    redirect_to @shift
  else
    render 'edit'
  end

end

def destroy
  @shift = Shift.find(params[:id])
  if @shift.destroy
    flash[:notice] = "Shift was sucessfully deleted."
    redirect_to @shift
  else
    flash.now[:alert] = "There was an error deleting the shift."
    render :show
  end
end



private
  def shift_params
    params.require(:shift).permit(:volunteer, :volunteer_two, :location, :date, :start, :end, :status, :congregation, {:request_by => []})
  end

  def add_request
    request_list = @shift[:request_by]
    volunteer = current_user[:name]
    request_list.unshift(volunteer)
    request_list.uniq!
    @shift[:status] = "requested" if @shift[:status] == "available"
  end


end

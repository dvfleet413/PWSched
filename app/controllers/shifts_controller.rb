require 'pry'

class ShiftsController < ApplicationController
before_action :authenticate_user!

def index
  @shifts = Shift.all
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
  binding.pry
end

def update
  @shift = Shift.find(params[:id])
  if !current_user.admin?
    add_request
  end
  @shift.update(shift_params)
  @shift.request_by.clear if @shift.status =="assigned"
  if @shift.update(shift_params)
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

def add_request
  request_list = @shift[:request_by]
  volunteer = current_user[:name]
  request_list << volunteer
  @shift[:status] = "requested" if @shift[:status] == "available"
end

def deny_dequest(shift, name)
  request_list = shift[:request_by]
  index = request_list.index(name)
  request_list.delete_at(index)
  request_list
end

private
  def shift_params
    params.require(:shift).permit(:volunteer, :location, :date, :start, :end, :status, :congregation, {:request_by => []})
  end
end

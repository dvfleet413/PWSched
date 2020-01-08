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
end

def update
  @shift = Shift.find(params[:id])

  if @shift.update(shift_params)
    redirect_to @shift
  else
    render 'edit'
  end
end

def destroy
  @shift = Shift.find(params[:id])
  @shift.destroy

  redirect_to shifts_path
end

private
  def shift_params
    params.require(:shift).permit(:volunteer, :location, :date, :start, :end)
  end
end

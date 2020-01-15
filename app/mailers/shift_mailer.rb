class ShiftMailer < ApplicationMailer
require 'pry'
  def shift_assigned_email(shift)
    @shift = shift
    user_name = @shift[:volunteer]
    user_id = 0
    User.all.map { |user| user_id = user[:id] if user[:name] == user_name }
    @user = User.find(user_id)
    binding.pry
    #Send email
    mail(to: @user[:email], subject: 'New PW Shift Assigned!')
  end
end

class ShiftMailer < ApplicationMailer
  def shift_assigned_email(shift)
    @shift = shift

    #Find User record for volunteer
    user_name = @shift[:volunteer]
    user_id = nil
    User.all.map { |user| user_id = user[:id] if user[:name] == user_name }
    @user = User.find(user_id)

    #Send email
    mail(to: @user[:email], subject: 'New PW Shift Assigned!') if user_id
  end

  def shift_requested_email(shift)
    @shift = shift

    #Find admin for associated Congregation
    admin_id = nil
    cong_name = @shift[:congregation]
    User.all.map {|user| admin_id = user[:id] if user[:congregation] == cong_name && user[:role] == "admin"}
    @user = User.find(admin_id)

    #Send email
    mail(to: @user[:email], subject: 'New PW Shift Request!') if admin_id

  end

  def weekly_summary_email(user, shifts)
    @user = user
    @shifts = shifts
    mail(to: user[:email], subject: "This week's PW Schedule")
  end

  def reminder_email(user, shifts)
    @user = user
    @shifts = shifts
    mail(to: user[:email], subject: "You have a PW shift tomorrow!") if @shifts.length > 0
  end
end

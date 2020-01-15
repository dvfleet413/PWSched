class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user[:email], subject: 'Welcome to PWSched!')
    user
  end

  def new_user_email(user)
    @user = user
    #Find admin for associated Congregation
    admin_id = nil
    cong_name = @user[:congregation]
    User.all.map {|user| admin_id = user[:id] if user[:congregation] == cong_name && user[:role] == "admin"}
    @admin = User.find(admin_id)

    #Send email
    mail(to: @admin[:email], subject: 'New PWSched User For Your Congregation!') if admin_id
  end
end

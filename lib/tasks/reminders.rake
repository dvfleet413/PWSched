namespace :reminders do
  desc "Send summary of upcoming shifts to all users"
  task weekly_summary: :environment do
    #iterate through each Congregation
    Congregation.all.map do |cong|
      #create an array of all shifts for the congregation
      @shifts = Shift.all.map {|shift| shift if shift[:congregation] == cong[:name]}
      #limit shifts to only those within the next 7 days - @shift[:date] < Date.today + 7
      @shifts.select! {|shift| shift[:date] < Date.today + 7}
      #create an array of all users in the congregation
      users = User.all.map {|user| user if user[:congregation] == cong[:name]}
      #iterate through users to send email

      users.each do |user|
        @user = user
        ShiftMailer.weekly_summary_email(@user, @shifts).deliver_now
      end
    end
  end

  desc "TODO"
  task night_before: :environment do
  end

end

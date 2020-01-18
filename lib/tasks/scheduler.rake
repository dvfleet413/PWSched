
desc "Send summary of upcoming shifts to all users"
task weekly_summary: :environment do
  if Time.now.sunday?
    puts "running rake weekly_summary"
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
  else
    puts "rake weekly_summary has run completely...today isn't the day to send emails!"
  end
end

desc "Send reminder if user has shift next day"
task night_before: :environment do
  puts "running rake night_before"
  #iterate through each Congregation
  Congregation.all.map do |cong|
    #create an array of all shifts for the congregation
    shifts = Shift.all.map {|shift| shift if shift[:congregation] == cong[:name]}
    #limit shifts to only those next day - @shift[:date] < Date.today + 1
    shifts.select! {|shift| shift[:date] == Date.today + 1}
    #create an array of all users in the congregation
    users = User.all.map {|user| user if user[:congregation] == cong[:name]}
    #iterate through users, only include shifts assigned to that user
    users.each do |user|
      @user = user
      @shifts = shifts.select {|shift| shift[:volunteer] == user[:name] || shift[:volunteer_two] == user[:name]}
      ShiftMailer.reminder_email(@user, @shifts).deliver_now
    end
  end
end

desc "Remove past shifts from database"
task delete_old_shifts: :environment do
  puts "removing past shifts..."
  Shift.all.map {|shift| shift.delete if shift[:date] < Date.today }
end

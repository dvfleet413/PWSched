class Congregation < ApplicationRecord

  def get_congregations
    all_congregations = []
    User.all.each.map do |user|
      if user[:role] == "admin"
        all_congregations << user[:congregation]
      end
    end
    return all_congregations
  end

end

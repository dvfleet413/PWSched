class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :name 

  enum role: [:volunteer, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :volunteer
    end
  end
end

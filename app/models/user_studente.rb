class UserStudente < ActiveRecord::Base
    validates :name, presence: true
    validates :surname, presence: true
    validates :email, presence: true
    validates :username, presence: true
    validates :fiscalCode, presence: true
    validates :birthDay, presence: true
end

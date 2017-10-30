class UserStudente < ActiveRecord::Base
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }
    validates :username, presence: true, length: { maximum: 50 }
    validates :fiscalCode, presence: true, length: { maximum: 16, minimum: 16 }
    validates :birthDay, presence: true
end

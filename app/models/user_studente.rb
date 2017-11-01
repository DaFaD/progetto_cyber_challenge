class UserStudente < ActiveRecord::Base
    validates :name, presence: true, length: { maximum: 50 }
    validates :surname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@(gmail.it|gmail.com|studenti.uniroma1.it)\z/i # /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
    validates :username, presence: true, length: { maximum: 50 }
    validates :fiscalCode, presence: true, length: { maximum: 16, minimum: 16 }
    validates :birthDay, presence: true
end

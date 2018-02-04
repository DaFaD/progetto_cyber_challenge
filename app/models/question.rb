class Question < ActiveRecord::Base
    validates :text, presence: true
    validates :ans1, presence: true
    validates :ans2, presence: true
    validates :ans3, presence: true
    validates :ans4, presence: true
    validates :ans_ok, presence: true

end

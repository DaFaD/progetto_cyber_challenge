class Advice < ActiveRecord::Base
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 1024 }
    validates :author, presence: true, length: { maximum: 50 }
    validates :writtenAt, presence: true
end

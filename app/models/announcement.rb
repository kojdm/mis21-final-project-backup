class Announcement < ApplicationRecord
  belongs_to :admin
  
  validates :subject, presence: true
  validates :content, presence: true
end

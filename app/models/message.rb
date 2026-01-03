class Message < ApplicationRecord
  belongs_to :user
  belongs_to :contact

  validates :title, presence: true
  validates :body, presence: true
end

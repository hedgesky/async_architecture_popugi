class Task < ApplicationRecord
  enum state: [:open, :done]

  belongs_to :assignee, class_name: 'Account'

  validates :description, presence: true
end

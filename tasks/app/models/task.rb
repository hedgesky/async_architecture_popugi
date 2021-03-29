class Task < ApplicationRecord
  enum state: [:open, :done]

  belongs_to :assignee, class_name: 'Account', optional: true

  validates :description, presence: true
end

class Task < ApplicationRecord
  enum state: [:open, :done]

  validates :description, presence: true
end

class Account < ApplicationRecord
  has_one :balance, dependent: :destroy

  has_many :task_assignments
  has_many :task_completions
end

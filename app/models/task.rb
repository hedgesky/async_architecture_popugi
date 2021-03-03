class Task < ApplicationRecord
  enum state: [:open, :done]
end

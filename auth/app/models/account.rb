class Account < ApplicationRecord
  validates :role, inclusion: { in: %w[admin manager accountant common] }
end

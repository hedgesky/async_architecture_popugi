class Account < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :role, inclusion: { in: %w[admin manager accountant common] }

  def admin?
    role == 'admin'
  end
end

class Account < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :role, inclusion: { in: %w[admin manager accountant common] }

  has_many :access_grants,
           class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  def admin?
    role == 'admin'
  end
end

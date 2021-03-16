# frozen_string_literal: true

class DeviseCreateAuthAdminAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :auth_admin_accounts, id: :uuid do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :auth_admin_accounts, :email,                unique: true
    add_index :auth_admin_accounts, :reset_password_token, unique: true
  end
end

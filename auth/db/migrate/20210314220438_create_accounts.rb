class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :email
      t.string :role, default: 'common'

      t.timestamps
    end
    add_index :accounts, :email, unique: true
  end
end

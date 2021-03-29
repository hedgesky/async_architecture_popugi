class CreateTaskAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :task_assignments, id: :uuid do |t|
      t.string :task_id, null: false
      t.text :task_description
      t.string :account_id, null: false

      t.timestamps
    end
  end
end

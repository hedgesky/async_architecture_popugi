class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.text :description
      t.integer :state, default: 0
      t.string :assignee_id

      t.timestamps
    end
  end
end

class CreateClosedTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :closed_tasks, id: :uuid do |t|
      t.string :task_id
      t.text :description
      t.string :assignee_id
      t.integer :completion_cost
      t.date :date

      t.timestamps
    end
  end
end

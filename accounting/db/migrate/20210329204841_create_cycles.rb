class CreateCycles < ActiveRecord::Migration[6.1]
  def up
    create_table :cycles, id: :uuid do |t|
      t.string :balance_id, null: false
      t.date :date, null: false

      t.timestamps
    end

    Balance.find_each do |balance|
      balance.cycles.create!(date: Date.today)
    end
  end

  def down
    drop_table :cycles
  end
end

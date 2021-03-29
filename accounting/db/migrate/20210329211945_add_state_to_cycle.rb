class AddStateToCycle < ActiveRecord::Migration[6.1]
  def change
    add_column :cycles, :state, :integer, default: 0
  end
end

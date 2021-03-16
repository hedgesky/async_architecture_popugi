class EnableUuid < ActiveRecord::Migration[6.1]
  def up
    enable_extension 'pgcrypto'
  end

  def down
  end
end

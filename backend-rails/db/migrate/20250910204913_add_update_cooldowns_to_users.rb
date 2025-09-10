class AddUpdateCooldownsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name_updated_at, :datetime
    add_column :users, :username_updated_at, :datetime
  end
end

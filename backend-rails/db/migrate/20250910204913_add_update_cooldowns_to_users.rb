class AddUpdateCooldownsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name_updated_at, :datetime unless column_exists?(:users, :name_updated_at)
    add_column :users, :username_updated_at, :datetime unless column_exists?(:users, :username_updated_at)
  end
end

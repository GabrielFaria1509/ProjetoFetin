class AddUserTypeUpdatedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_type_updated_at, :datetime
  end
end
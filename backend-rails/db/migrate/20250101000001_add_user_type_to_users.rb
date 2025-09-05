class AddUserTypeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_type, :string, default: 'Responsável' unless column_exists?(:users, :user_type)
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
  end
end
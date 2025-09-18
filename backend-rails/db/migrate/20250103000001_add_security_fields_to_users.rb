class AddSecurityFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_verified, :boolean, default: false
    add_column :users, :firebase_uid, :string
    add_index :users, :firebase_uid, unique: true
  end
end
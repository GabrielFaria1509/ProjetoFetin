class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_type, :string, default: 'Responsável'
    add_column :users, :profile_image_url, :string
  end
end
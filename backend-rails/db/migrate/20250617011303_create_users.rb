class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :profile_picture
      t.string :bio
      t.string :location
      t.string :website
      t.timestamps
    end
  end
end

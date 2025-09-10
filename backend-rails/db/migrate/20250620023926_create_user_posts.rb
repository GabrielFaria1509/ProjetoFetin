class CreateUserPosts < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:user_posts)
      create_table :user_posts do |t|
        t.string :title
        t.text :content
        t.references :user, null: false, foreign_key: true
        t.references :forum, null: false, foreign_key: true

        t.timestamps
      end
    end
  end
end

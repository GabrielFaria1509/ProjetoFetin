class CreatePostComments < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:comments)
      create_table :comments do |t|
        t.references :post, null: false, foreign_key: true
        t.references :user, null: false, foreign_key: true
        t.text :content

        t.timestamps
      end
    end
  end
end

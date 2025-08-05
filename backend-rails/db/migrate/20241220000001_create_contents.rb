class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :category, null: false
      t.string :author, null: false
      t.string :image_url
      t.datetime :published_at

      t.timestamps
    end

    add_index :contents, :category
    add_index :contents, :published_at
  end
end
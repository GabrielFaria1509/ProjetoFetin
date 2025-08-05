class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.text :description
      t.string :resource_type, null: false
      t.string :file_url
      t.string :drive_id
      t.string :category
      t.integer :file_size
      t.string :file_format

      t.timestamps
    end

    add_index :resources, :resource_type
    add_index :resources, :category
  end
end
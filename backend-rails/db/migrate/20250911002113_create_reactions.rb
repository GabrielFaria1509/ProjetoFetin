class CreateReactions < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:reactions)
      create_table :reactions do |t|
        t.references :user, null: false, foreign_key: true
        t.references :post, null: false, foreign_key: true
        t.string :reaction_type, null: false

        t.timestamps
      end
      add_index :reactions, [:user_id, :post_id], unique: true
      add_index :reactions, [:post_id, :reaction_type]
    end
  end
end

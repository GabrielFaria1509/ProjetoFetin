class FixCommentsTable < ActiveRecord::Migration[7.2]
  def change
    # Remover foreign key e coluna user_post_id
    remove_foreign_key :comments, :user_posts if foreign_key_exists?(:comments, :user_posts)
    remove_column :comments, :user_post_id if column_exists?(:comments, :user_post_id)
    
    # Adicionar post_id se não existir
    unless column_exists?(:comments, :post_id)
      add_reference :comments, :post, null: false, foreign_key: true
    end
  end
end
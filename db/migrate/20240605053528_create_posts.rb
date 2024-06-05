class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.text :ingredient, null: false
      t.text :method, null: false
      t.integer :level, null: false
      t.integer :originality, null: false
      
      
    end
  end
end

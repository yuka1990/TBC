class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.text :body, null: false
      
    end
  end
end

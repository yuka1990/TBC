class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      
    end
  end
end

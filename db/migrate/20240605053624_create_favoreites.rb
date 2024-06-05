class CreateFavoreites < ActiveRecord::Migration[6.1]
  def change
    create_table :favoreites do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
    end
  end
end

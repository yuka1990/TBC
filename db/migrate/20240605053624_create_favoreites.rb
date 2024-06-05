class CreateFavoreites < ActiveRecord::Migration[6.1]
  def change
    create_table :favoreites do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
    end
  end
end

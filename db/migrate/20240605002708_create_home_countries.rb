class CreateHomeCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :home_countries do |t|

      t.timestamps
      t.string :name, null: false
      
    end
  end
end

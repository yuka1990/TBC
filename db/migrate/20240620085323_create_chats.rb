class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|

      t.timestamps
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.text :message, null: false
      
    end
  end
end

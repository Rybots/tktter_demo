class CreateFavs < ActiveRecord::Migration[4.2][5.1]
  def change
    create_table :favs do |t|
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end

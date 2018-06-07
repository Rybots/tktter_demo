class CreateTickets < ActiveRecord::Migration[4.2][5.1]
  def change
    create_table :tickets do |t|
      t.datetime :schedule
      t.text :venue
      t.text :seat
      t.text :price
      t.text :comment
      t.integer :artist_id
      t.integer :user_id

      t.timestamps
    end
    add_index :tickets, :artist_id
    add_index :tickets, :user_id
  end
end

class CreateUsers < ActiveRecord::Migration[4.2][5.1]
  def change
    create_table :users do |t|
      t.string :screen_name
      t.string :name
      t.string :image
      t.text :email
      t.text :url

      t.timestamps
    end
  end
end

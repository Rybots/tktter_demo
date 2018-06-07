class CreateArtists < ActiveRecord::Migration[4.2][5.1]
  def change
    create_table :artists do |t|
      t.string :genre
      t.string :gyou
      t.string :name
      t.string :romaji
      t.text :image
      
      t.timestamps
    end
  end
end

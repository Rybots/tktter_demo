require 'csv'

Artist.destroy_all
Ticket.destroy_all
#Course.destroy_all
#School.destroy_all
#Prefecture.destroy_all

#csvから読み込み
CSV.foreach("db/new_artist.csv",:encoding => "Windows-31J:UTF-8",:headers => true) do |row|
  Artist.create(genre: "music",gyou: row[0],name: row[1],romaji: row[2])
end

CSV.foreach("db/baseball.csv",:encoding => "Windows-31J:UTF-8",:headers => true) do |row|
  Artist.create(genre: "baseball",gyou: "",name: row[0],romaji: row[1],image: row[2])
end

CSV.foreach("db/soccer.csv",:encoding => "Windows-31J:UTF-8",:headers => true) do |row|
  Artist.create(genre: row[3],gyou: "",name: row[0],romaji: row[1],image: row[2])
end

#100.times do |n|
# Ticket.create(schedule: "Fri, 22 Mar 2019 17:02:00 JST +09:00",venue: "埼玉スーパーアリーナ",seat: "A53",price: 1000,comment: "特にナシ",artist_id: 1,user_id: 1)
#end 

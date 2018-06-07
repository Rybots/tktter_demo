require 'csv'
require 'kconv'
require 'kakasi'

$newdatas = []
$b_gyous = []
$b_names = []
$b_romajis = []
$r_gyous = []
$r_names = []
$r_romajis = []

#csvから読み込み
def in_csv_analysis
  CSV.foreach("db/bookoff_artist.csv",:encoding => "windows-31j:utf-8",:headers => true) do |row|
    $b_gyous << row[0]
    $b_names << row[1]
    $b_romajis << row[2]
  end

  CSV.foreach("db/rakuten_artist.csv",:encoding => "windows-31j:utf-8",:headers => true) do |row|
    $r_gyous << row[0]
    $r_names << row[1]
    $r_romajis << row[2]
  end

  $r_names.each_with_index do |name,i|
    if $b_names.index(name)
      $r_romajis[i] = $b_romajis[$b_names.index(name)] 
    end
  end

#各配列を結合
  $newdatas << $r_gyous
  $newdatas << $r_names
  $newdatas << $r_romajis

 p  $newdatas = $newdatas.transpose
end

#CSVに出力
def to_csv
  header = ["行","名前","ローマ字"]
  CSV.open('db/new_artist.csv','w',:encoding => "SJIS",:headers => true) do |file|
     file << header
   $newdatas.each do |line| 
      file << line
    end
  end
  puts "--------------------------------------------------------------------    ------"
  puts "result.csv を書き出しました"
  puts "--------------------------------------------------------------------------" 
end

in_csv_analysis
to_csv

puts "ミッションコンプリート"

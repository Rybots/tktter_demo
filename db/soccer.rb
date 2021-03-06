require 'rubygems'
require 'nokogiri'
require 'kconv'
require "open-uri"
require 'kakasi'
require 'csv'
require 'mechanize'

class String
  def sjisable
    str = self
#変換テーブル上の文字を下の文字に置換する
    from_chr = "\u{301C 2212 00A2 00A3 00AC 2013 2014 2016 203E 00A0 00F8 203A}"
    to_chr   = "\u{FF5E FF0D FFE0 FFE1 FFE2 FF0D 2015 2225 FFE3 0020 03A6 3009}"
    str.tr!(from_chr, to_chr)
#変換テーブルから漏れた不正文字は?に変換し、さらにUTF8に戻すことで今後例外を出さないようにする
    str = str.encode("Windows-31J","UTF-8",:invalid => :replace,:undef=>:replace).encode("UTF-8","Windows-31J")
  end
end

  module CSVEncodingExtension
    def initialize(data, options = Hash.new)
      options.delete(:replace)
      options.delete(:undef)
      super
    end
  end
  CSV.send(:prepend, CSVEncodingExtension)

$team = []
def scrape
  img = []
  agent = Mechanize.new
  agent.user_agent_alias = 'Mac Safari 4'
  page = agent.get("https://soccer.sports.smt.docomo.ne.jp/jleague/team/j1/")
  doc = Nokogiri::HTML.parse(page.body).css(".list")
  doc.css("li").each do |li|
    img << li.inner_text.gsub(/\t|\r|\n/,"")
#      img << Kakasi.kakasi("-JH -KH -aH -s",li.inner_text.gsub(/\t|\r|\n/,""))
    img << li.css('img').attribute("src").value.gsub(/\/img\/emblem\/|\.png/,"")
    img << "https://soccer.sports.smt.docomo.ne.jp" + li.css('img').attribute("src").value
    img << "soccer_j1"
# puts team
    $team << img
    img = []
  end

  page = agent.get("https://soccer.sports.smt.docomo.ne.jp/jleague/team/j2/")
  doc = Nokogiri::HTML.parse(page.body).css(".list")
  doc.css("li").each do |li|
    img << li.inner_text.gsub(/\t|\r|\n/,"")
#      img << Kakasi.kakasi("-JH -KH -aH -s",li.inner_text.gsub(/\t|\r|\n/,""))
    img << li.css('img').attribute("src").value.gsub(/\/img\/emblem\/|\.png/,"")
    img << "https://soccer.sports.smt.docomo.ne.jp" + li.css('img').attribute("src").value
    img << "soccer_j2"
# puts team
    $team << img
    img = []
  end
end
scrape

def to_csv
  header = ["名前","ローマ字","画像","リーグ"]  
  CSV.open('soccer.csv','w',:encoding => "Shift_JIS:UTF-8",:headers => true, undef: :replace, replace: '-') do |file|  
    file << header
    $team.each do |line|
      file << line
    end
  end
 puts "CSV出力--------------------------------------------------------------------------"
end
to_csv

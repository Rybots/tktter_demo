class ArtistsController < ApplicationController
#before_action :auth_devise_user!, except: [:top,:show,:fav] 
before_action :top_auth_devise_user, only: [:top,:show]

  def top
    @artists = Artist.where(genre: "music")
    @baseballs = Artist.where(genre: "baseball")
    @soccers = Artist.where(genre: "soccer_j1") + Artist.where(genre: "soccer_j2")
  end

  def show
#if params[:romaji] == "favicon"
#     redirect_to session[:previous_url]
#   else
#リロードしたときのバグ対応
    if request.fullpath == "/devise_users" 
      redirect_to new_devise_user_registration_path
    elsif request.fullpath == "/devise_users/password"
      redirect_to new_password_path(resource_name)
    else
      @artist = Artist.find_by(romaji: params[:romaji])
      @tickets = Ticket.where(artist_id: @artist.id).order("created_at DESC").page(params[:page]).per(20)
      sakuin = [
        "アイウエオ",
        "カキクケコ",
        "サシスセソ",
        "タチツテト",                                       
        "ナニヌネノ",
        "ハヒフヘホ",
        "マミムメモ",
        "ヤユヨ",
        "ラリルレロ",
        "ワオン"
      ]
      num = (sakuin.join =~ /#{@artist.gyou}/)
      if num.to_i.between?(0, 4)
        gyou = "ア"
        row = 0
      elsif num.to_i.between?(5,9)
        gyou = "カ"
        row = 1
      elsif num.to_i.between?(10,14)
        gyou = "サ"
        row = 2 
      elsif num.to_i.between?(15,19)
        gyou = "タ"
        row = 3 
      elsif num.to_i.between?(20,24)
        gyou = "ナ"
        row = 4
      elsif num.to_i.between?(25,29)
        gyou = "ハ"
        row = 5
      elsif num.to_i.between?(30,34)
        gyou = "マ"
        row = 6
      elsif num.to_i.between?(35,37)
        gyou = "ヤ"
        row = 7
      elsif num.to_i.between?(38,42)
        gyou = "ラ"
        row = 8
      elsif num.to_i.between?(43,45)
        gyou = "ワ"
        row = 9
      end
#  puts  sakuin.join.match(/#{@artist.gyou}/)

      if @artist.gyou.present? 
        add_breadcrumb 'アーティスト一覧', "/"
        add_breadcrumb "#{gyou}行", "/?row=#{row}"
        add_breadcrumb "#{@artist.gyou}", "/?index=#{num}"
        add_breadcrumb "#{@artist.name}", "/#{@artist.romaji}"
      else
        if @artist.genre == "baseball"
          name = "野球"
        elsif @artist.genre == "soccer_j1"
          name = "サッカー・J1"
        elsif @artist.genre == "soccer_j2"
          name = "サッカー・J2"
        end
        add_breadcrumb 'トップ', "/"
        add_breadcrumb "#{name}", "/?genre=#{@artist.genre}"
        add_breadcrumb "#{@artist.name}", "/#{@artist.romaji}"
      end
    end
  end

  def fav
    array = []
    cookies.each do |cookie|
      if cookie[0] =~ /data_/ && cookie[1] == "1"
        array << cookie[0].scan(/data_(.+)/)[0]
      end
    end
    array.flatten!
    @tickets = Ticket.where(id: array).order("created_at DESC").page(params[:page]).per(20)
  end

  private
  def artist_params
    params.require(:artist).permit(:id,:gyou,:name,:romaji)
  end
end

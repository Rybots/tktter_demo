class TicketsController < ApplicationController
before_action :auth_devise_user!, except: [:show,:report,:report_send]
before_action :top_auth_devise_user, only: [:show]
impressionist actions: [:show]

  def report
    @report = Report.new
  end

  def report_send
  # 入力値のチェック
  @report = Report.new(report_params)
  if @report.valid?
    # OK。確認画面を表示
    ReportMailer.received_email(@report).deliver
    redirect_to session[:previous_url],flash: {success: 'ご報告ありがとうございました。対応させていただきます。'}  
  else
    # NG。入力画面を再表示
    render :action => 'report'
  end
  end

  def sell
    @ticket = Ticket.new 
    @artist_id = Artist.find_by(romaji: params[:romaji]).id
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @artist_id = Artist.find_by(romaji: params[:romaji]).id
    url = Rails.application.routes.recognize_path(request.referrer)
    session[:previous_edit_controller] = url[:controller]
    session[:previous_edit_action] = url[:action]
  end 

  def update   
    @ticket = Ticket.find(params[:id])
    @artist_id = Artist.find_by(romaji: params[:romaji]).id
    if @ticket.update(ticket_params)
      if session[:previous_edit_controller] == "artists" && session[:previous_edit_action] == "show"
        redirect_to ({controller: 'artists', action: 'show', romaji: params[:romaji]}), flash: {success: 'チケットが更新されました'}
        session[:previous_edit_controller] = nil
        session[:previous_edit_action] = nil
      elsif session[:previous_edit_controller] == "tickets"
       redirect_to ({controller: 'tickets', action: 'show', romaji: params[:romaji], id: params[:id]}), flash: {success: 'チケットが更新されました'}
        session[:previous_edit_controller] = nil
        session[:previous_edit_action] = nil
      elsif session[:previous_edit_controller] == "users"
       redirect_to ({controller: 'users', action: 'my_page'}), flash: {success: 'チケットが更新されました'}
        session[:previous_edit_controller] = nil
        session[:previous_edit_action] = nil
      elsif session[:previous_edit_action] == "fav"
       redirect_to ({controller: 'artists', action: 'fav'}), flash: {success: 'チケットが更新されました'}
        session[:previous_edit_controller] = nil
        session[:previous_edit_action] = nil
      end
    else       
      render :edit
    end        
  end      

  def ticket_create
    @ticket = Ticket.new(ticket_params)
    @artist_id = Artist.find_by(romaji: params[:romaji]).id
    if @ticket.save
#      user = User.find(praise_params[:user_id])
#     if User.find(praise_params[:user_id]).email.present?
#     end
      redirect_to artist_path(params[:romaji]), flash: {success: "投稿しました"}
    else                                                                 
      render :sell# ,flash: {error: 'もう1度やり直して下さい'}
    end  
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    ticket = @ticket
    @ticket.destroy
    redirect_to session[:previous_url], flash: {success: "削除しました"}
  end

  def show
    if request.original_url =~ /devise_users\/sign_out/ 
      redirect_to session[:previous_url]
    else
      @ticket = Ticket.find(params[:id])  
      @artist = @ticket.artist
#impressionist(@user, nil, :unique => [:session_hash])
      @page_views = @ticket.impressionist_count
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
        "ワヲン"
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
      add_breadcrumb 'アーティスト一覧', "/"
      add_breadcrumb "#{gyou}行", "/?row=#{row}"
      add_breadcrumb "#{@artist.gyou}", "/?index=#{num}"
      add_breadcrumb "#{@artist.name}", "/#{@artist.romaji}"
    end
  end

private
  def ticket_params
    params.require(:ticket).permit(:schedule,:venue,:seat,:price,:comment,:user_id,:artist_id)
  end 

  def report_params
    params.require(:report).permit(:name, :email, :message, :artist, :ticket)
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :store_location

  def store_location
# 今回の場合は、 /users/sign_in , /users/sign_up, /users/password にアクセスしたとき、ajaxでのやりとりはsessionには保存しない。
    if (request.fullpath != "/devise_users/sign_in" && \
      request.fullpath != "/devise_users/sign_up" && \
      request.fullpath != "/devise_users/sign_out" && \
      request.fullpath != "/devise_users/password" && \
      request.fullpath != "/login" && \
      request.fullpath != "/devise_users/auth/twitter" && \
      request.fullpath != "/devise_users/auth/facebook" && \
      request.fullpath != "/devise_users" && \
      request.fullpath !~ /\/devise_users\/auth\/twitter\/callback/ && \
      request.fullpath !~ /\/devise_users\/auth\/facebook\/callback/ && \
      request.fullpath != "/" && \
      request.fullpath != "/u/14297811" && \
      request.fullpath !~ /\/u\/14297811/ && \
      request.fullpath !~ /\/u\/^[0-9]+$/ && \
      request.fullpath !~ /report\?/ && \
      request.fullpath !~ /favicon/ && \
      request.fullpath !~ /logo\.png/ && \
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
#     puts session[:previous_url]
    end
  end

#ログイン後のリダイレクトをログイン前のページにする場合
  def after_sign_in_path_for(resource)
    if session[:previous_url].present?
      session[:previous_url]
    else
      root_path
    end
  end

#def after_sign_in_path_for(resource)
#  @user = User.find(current_devise_user.id)
# if (@user.screen_name.blank?) || (@user.name.blank?)
# edit_user_path(14297811)# and return                    
#   privacy_path
#  else
#    session[:previous_url] || root_path
#  end
#end
#ログアウト後のリダイレクトをログアウト前のページにする場合
  def after_sign_out_path_for(resource)
   artists_path
  end

  protected
  def auth_devise_user!
    if devise_user_signed_in? #プロフの必須情報入力画面に遷移
      @user = User.find(current_devise_user.id)
      if (@user.screen_name.blank?) || (@user.name.blank?)
        flash[:notice] = "プロフィールを完成させて下さい"      
        if @user.screen_name.blank?
          redirect_to edit_user_path(14297811)
        elsif @user.name.blank?
          redirect_to edit_user_path(@user)
        end
      end                                                       
    else #アカウント作成画面に遷移
      store_location_for(:devise_user, request.url)
      redirect_to new_devise_user_registration_url
    end
  end

  def top_auth_devise_user
    if devise_user_signed_in? #プロフの必須情報入力画面に遷移
      @user = User.find(current_devise_user.id)
      if (@user.screen_name.blank?) || (@user.name.blank?)
        flash[:notice] = "プロフィールを完成させて下さい"      
        if @user.screen_name.blank?
          redirect_to edit_user_path(14297811)
        elsif @user.name.blank?
          redirect_to edit_user_path(@user)
        end
      end
#    else
#edit_user_path(1111)
    end
  end 
end

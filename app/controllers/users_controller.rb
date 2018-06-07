class UsersController < ApplicationController
after_action :store_location

  def my_page
    @user = User.find(current_devise_user.id)
    @tickets = @user.tickets.page(params[:page]).per(20)
  end 

  def login
    if signed_in?
      @user = User.find(current_devise_user.id)
      if (@user.screen_name.blank?) || (@user.name.blank?)
        flash[:notice] = "プロフィールを完成させて下さい"
        if @user.screen_name.blank?
          redirect_to edit_user_path(14297811)
        elsif @user.name.blank?
          redirect_to edit_user_path(@user)
        end
      else
        redirect_to edit_user_path(@user.screen_name)
      end
    else
      flash[:success]="ログインしてください"
    end
  end

  def edit
    @user = User.find(current_devise_user.id)
  end

  def update                                                                              
    @user = User.find(current_devise_user.id)
    if @user.update_attributes(user_params)
#redirect_to user_path(@user), flash: {success: "プロフィールが更新されました"}
#      redirect_back fallback_location: root_path, flash: {success: "プロフィールが更新されました"}
      redirect_to session[:previous_url], flash: {success: "プロフィールが更新されました"}
    else
      render :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:id,:email,:name,:screen_name,:image,:icon_cache,:remove_icon)                                          
  end
end

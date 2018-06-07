class DeviseUser < ApplicationRecord
belongs_to :user, optional: true
#attr_accessible :provider, :uid, :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter,:facebook]
  devise :timeoutable, :timeout_in => 30.years


def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    devise_user = DeviseUser.where(provider: auth.provider, uid: auth.uid).first
    unless devise_user
      user = User.create(email: auth.info.email,name: auth.extra.raw_info.name,image: auth[:info][:image],url: auth.extra.raw_info.link)
      devise_user = DeviseUser.create(
        provider: auth.provider,
        uid:      auth.uid,
        token:    auth.credentials.token,
        email:    auth.info.email,
        password: Devise.friendly_token[0,20],
        user_id: user.id,
        )
    end
    return  devise_user
  end

# def self.new_with_session(params, session)
#   super.tap do |user|
#     user.email = data["email"] if user.email.blank?
#   end
#end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    devise_user = DeviseUser.where(:provider => auth.provider, :uid => auth.uid).first
    unless devise_user
      user = User.create(email: "",screen_name: auth.info.nickname,name: auth.info.name,image: auth.info.image)
      devise_user = DeviseUser.create(
        real_screen_name: auth.info.nickname,
        provider: auth.provider,
        token:    auth.credentials.token,                                                           uid:      auth.uid,
        email:    DeviseUser.create_unique_email,
        password: Devise.friendly_token[0,20],
        user_id: user.id
      )
    end  
    return  devise_user
  end 

  def self.create_unique_string
    SecureRandom.uuid
  end              
  # twitterではemailを取得できないので、適当に一意のemailを生成                                                                         
  def self.create_unique_email
    DeviseUser.create_unique_string + "@example.com"
  end    
end

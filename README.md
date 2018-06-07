# README

http://tktter.com/

手順

* config/initializers/devise.rb
  omniauth系のキーを入れる

* config/environments/.rb
  メールアドレス&パスワード変更

* app/mailers/
  メアド変更

* bundle i

* bundle exec rake db:create

* bundle exec rake db:migrate

* bundle exec rake db:seed

* rails s

# README

# ◆起動をするためにまずやること

## ●ruby2.6.5を導入したくない人向け

ruby2.6.5を使用する想定ですが入れたくない人は次のコマンドを実行してください。

```
## 実行場所:free-market_sample

rbenv local `rbenv global`
```

## ●ruby2.6.5の導入

以下のコマンドでruby2.6.5を入れてください。

```
## 実行場所:どこでも可

rbenv install 2.6.5
```

```
## 実行場所:free-market_sample

rbenv global 2.6.5
```

## ●bundle install

rubyの準備ができたらbundle installを行ってください。

```
## 実行場所:free-market_sample
bundle install
```

## ●mysql5.7を導入したくない人向け

もしmysql5.7を入れたくない場合はconfig/database.ymlを編集してください。

```
default: &default
  adapter: mysql2
  encoding: utf8mb4   ## ここを "utf8" に変更
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password:
  socket: /tmp/mysql.sock
```

database.ymlを編集した場合はrails db:dropでデータベースを作り直してください。

## ●mysql5.7の導入

mysql5.7を導入する場合は以下のコマンドでmysql5.7を入れてください。

mysql@5.6を以下のコマンドで削除してください。

```bash:
## 実行場所:どこでも
mysql.server stop
brew uninstall mysql@5.6
```

次にmysql@5.7を入れます。

```bash:
## 実行場所:どこでも
brew install mysql@5.7
```

mysqlを起動させますが失敗する可能性があるので次のコマンドを実行しておきます。

```bash:
## 実行場所:どこでも
sudo rm -rf /tmp/mysql.sock
sudo pkill -kill -f mysql
```

次にbash_profile、もしくはzshrcを編集します。

```bash:
## 実行場所:どこでも
vim ~/.zshrc
## もしくは
vim ~/.bash_profile
```

mysql@5.6のパスを通す記述があるはずなので5.7に変更してください。

```bash:
## before
export PATH=/usr/local/opt/mysql@5.6/bin:$PATH

## after
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
```

ここまで出来たらmysqlを起動させてください。

```bash:
## 実行場所:どこでも
mysql.server start
```

起動できたら次のコマンドを実行しておきましょう。これはmysql5.6から5.7にアップグレードしたことが原因で起こるエラーを回避するために行います。

```
## 実行場所:どこでも
mysql_upgrade -u root --force
mysql.server restart
```

次にmysqlの自動起動について再設定しておきます。

```
## 実行場所:どこでも
rm -rf ~/Library/LaunchAgents
mkdir ~/Library/LaunchAgents
ln -sfv /usr/local/opt/mysql\@5.7/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql\@5.7.plist 
```

最後にmysql2のgemを入れ直しておきましょう。
mysqlのバージョンを変更するとこのgemでエラーが発生する場合があるためです。

```bash:
## 実行場所:free-market_sample
gem uninstall -aIx mysql2
bundle install
```

## ●credentials.ymlの用意

`credentials.yml.enc`と`master.key`は新しく用意していただく必要があります。

まずは`credentials.yml.enc`と`master.key`のペアを再生成するためにファイルを削除しましょう。

```
## 実行場所:free-market_sample
rm config/credentials.yml.enc
```

次にcredentials.ymlを開くコマンドを実行します。これで再生成されます。

```
## 実行場所:free-market_sample
EDITOR="vi" rails credentials:edit
```

開けたら以下のフォーマットでご自身のキーをセットしてください。
最初から記述されているsecret_key_baseはそのままにしておいてください。

```
aws:
  access_key_id: AKIA*************
  secret_access_key: *************

basic:
  user_name: "****"
  password: "****"

recaptcha:
  site_key: *************
  secret_key: *************

google:
  client_id: *************.apps.googleusercontent.com
  client_secret: *************
 
payjp:
  public_key: pk_test_*************
  secret_key: sk_test_*************

database_password: *************
```

## ●rails sの起動

bundle installやrails db:createに加えてrails db:seedも行ってください。

```
## 実行場所:free-market_sample

rails db:create
rails db:migrate
rails db:seed
rails s
```

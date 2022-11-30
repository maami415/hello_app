# ベースイメージを指定
FROM ruby:3.0.5

# railsに必要なnodejsとpostgeqsqlをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs

# ディレクトリ・ファイルの作成
RUN mkdir /hello_app
WORKDIR /hello_app
ADD Gemfile /hello_app/Gemfile
ADD Gemfile.lock /hello_app/Gemfile.lock

# Railsに必要なGemのインストール
RUN bundle install
COPY . /hello_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# railsを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
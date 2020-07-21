FROM ruby:2.7

RUN mkdir /gpets-web
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
RUN gem install bundler:1.17.3

COPY package.json /gpets-web/package.json
COPY yarn.lock /gpets-web/yarn.lock
COPY Gemfile /gpets-web/Gemfile
COPY Gemfile.lock /gpets-web/Gemfile.lock

WORKDIR /gpets-web

RUN yarn install --production
RUN bundle install

COPY . /gpets-web

RUN SECRET_KEY_BASE=1 RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 3000

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:2.7
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
RUN gem install bundler:1.17.3
WORKDIR /gpets-web
COPY package.json /gpets-web/package.json
COPY yarn.lock /gpets-web/yarn.lock
RUN yarn install --production
COPY Gemfile /gpets-web/Gemfile
COPY Gemfile.lock /gpets-web/Gemfile.lock
RUN bundle install
COPY . /gpets-web
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

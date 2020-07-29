FROM ruby:2.5.5

RUN gem install bundler && mkdir /app

COPY Gemfile /app/
COPY Gemfile.lock /app/
WORKDIR /app
RUN bundle install

COPY common.rb /app/
COPY env.sh /app/
COPY lita_config.rb /app/
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]

FROM ruby:2.2

RUN groupadd myapp --gid 6156 && \
    useradd --home /home/myapp --create-home --shell /bin/false --uid 6157 --gid 6156 myapp

ENV BUNDLE_APP_CONFIG .

USER myapp
WORKDIR /home/myapp

COPY Gemfile /home/myapp/
COPY Gemfile.lock /home/myapp/
RUN bundle install --deployment --without development test
COPY . /home/myapp/

CMD bundle exec foreman start

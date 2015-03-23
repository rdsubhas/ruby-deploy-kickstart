FROM ruby:2.2

# Create user and group
RUN groupadd myapp --gid 6156 && \
    useradd --home /home/myapp --create-home --shell /bin/false --uid 6157 --gid 6156 myapp

# Docker Ruby image has some quirks that disallow it from running as a normal user
ENV BUNDLE_APP_CONFIG .

# Run stuff as myapp from now on
USER myapp

# Create and switch to the repo dir
ENV REPO_DIR /home/myapp/repo
RUN mkdir $REPO_DIR
WORKDIR $REPO_DIR

# First install gems
COPY Gemfile $REPO_DIR/
COPY Gemfile.lock $REPO_DIR/
RUN bundle install --deployment --without development test

# Then copy over rest of the app
# .dockerignore will ensure that unnecessary files aren't copied
COPY . $REPO_DIR

# This will be the default command
CMD bundle exec foreman start

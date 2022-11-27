# Pull ruby image
FROM ruby:5.1.6

# Install 
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs           

# Create working directory
ENV APP_ROOT /rails_tutorial
RUN mkdir $APP_ROOT

# Set working directory as APP_ROOT
WORKDIR $APP_ROOT

# Add Gemfile
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Install Gemfile's bundle
RUN bundle install
ADD . $APP_ROOT
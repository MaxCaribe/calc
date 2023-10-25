FROM ruby:3.2.2

COPY . /app/
WORKDIR /app
RUN bundle install

EXPOSE 3003

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "3003"]
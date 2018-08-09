[ ![Codeship Status for gymcloud/GymCloud-API](https://codeship.com/projects/a47a7270-05d1-0133-0fe8-22315beb1c0d/status?branch=master)](https://codeship.com/projects/89539)

# GymCloud API

## Development

### Setup

```
cp .env.sample .env
cp config/database.yml.sample config/database.yml
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Usage

#### Services

Run services in separate terminals:

```
bundle exec rails console
bundle exec rails server
bundle exec guard
```

#### Guard

Guard will:

* Run testing suite (`rspec`)
* Run code style QA (`rubocop`)
* Install rubygems from Gemfile (`bundle install`)

#### API Documentation (Swagger)

```
http://localhost:3000/swagger
```

#### Admin UI

```
http://localhost:3000/admin
```

* defaults: `admin@example.com` : `password`


#### Emails manager

```
http://localhost:3000/letter_opener
```

#### Backgroud jobs manager (Sidekiq)

```
http://localhost:3000/sidekiq
```

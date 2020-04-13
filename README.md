# sample-ruby-on-rails

This is a study case of a Blog REST API in [Ruby] using [Ruby on Rails] framework with [PostgreSQL] database. For testing and documentation, [Swagger] was implemented at http://localhost:3000/api-docs using the [rswag]. Tests were implemented using [RSpec]. Working on the [Docker] configuration and after deploy it to [Heroku].

## System dependencies

 - [Ruby] Version 2.6
 - [Ruby on Rails]
 - [PostgreSQL] 10
 - [Docker]

## Configuration

To create the databases for the several environments
```sh
rake db:setup
```

## Database initialization

To add initial elements:
```sh
rails db:migrate
rails db:seed
```

## Swagger

Generate [OpenApi] documentation for [Swagger]:
```sh
rake rswag:specs:swaggerize

or

RAILS_ENV=test rails rswag
```

## How to run the test suite

```sh
bundle exec rspec
```
## Deployment instructions

Deploy the server locally
```sh
rails server
```

Deploy the server on [Docker]
```sh
docker-compose up --detach
docker-compose exec web bundle exec rake db:setup db:migrate
```

> It is available at  http://localhost:3000 and [Swagger] at http://localhost:3000/api-docs

Deploy the server on [Docker] after the database is created
```sh
docker-compose up --build
```
> It doesn't work on windows because of this https://github.com/docker-library/postgres/issues/435

Docker variables
```yml
development:
  url: <%= ENV['DATABASE_URL'].gsub('?', '_development?' ) %>
```
## Debugging

It can be debugged in [Visual Studio Code], the `launch.json` has the necessary configuration.

> If using Windows, [this](https://github.com/rubyide/vscode-ruby/issues/113#issuecomment-288667216) fix might be needed

### For Windows

```sh
set RAILS_ENV=test
```

```sh
rails generate rspec:install
```

### License

MIT License

### Reference

Update Rails
```sh
gem update rails
```

It will also create a database under the supplied username which can be used to connect to in rails console
```sh
docker-compose exec postgres psql -U postgres
```

To stop [Docker] containers
```sh
docker-compose stop
```

To clean [Docker] containers, images and build cache
```sh
docker system prune
```

```sh
docker-compose run web rake db:create
```

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)
[Docker]: <https://www.docker.com/>
[Heroku]: <https://www.heroku.com/>
[OpenApi]: <https://www.openapis.org/>
[PostgreSQL]: <https://www.postgresql.org/>
[RSpec]: <https://rspec.info/>
[rswag]: <https://github.com/rswag/rswag>
[Ruby]: <https://www.ruby-lang.org/en/>
[Ruby On Rails]: <https://rubyonrails.org/>
[Swagger]:<https://swagger.io/>
[Visual Studio Code]: <https://github.com/rubyide/vscode-ruby/issues/113#issuecomment-288667216>
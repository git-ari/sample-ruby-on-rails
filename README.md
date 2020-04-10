# sample-ruby-on-rails

This is a study case of a Blog REST API in [Ruby] using [Ruby on Rails] framework with [PostgreSQL] database. For testing and documentation, [Swagger] was implemented at http://localhost:3000/api-docs.

## System dependencies

 - [Ruby] Version 2.6
 - [Ruby on Rails]
 - [PostgreSQL] 10

## Configuration

## Database creation

To create the databases for the several environments:
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

rails rswag
```

## How to run the test suite

```sh
bundle exec rspec
```
## Deployment instructions

To deploy the the server:
```sh
rails server
```

```sh
docker-compose run web rake db:create
```

```sh
docker build -t web .
```

```sh
docker-compose up
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

Generate documentation
```sh
rake swagger:docs
```

[OpenApi]: <https://www.openapis.org/>
[PostgreSQL]: <https://www.postgresql.org/>
[rswag]: <https://github.com/rswag/rswag>
[Ruby]: <https://www.ruby-lang.org/en/>
[Ruby On Rails]: <https://rubyonrails.org/>
[Swagger]:<https://swagger.io/>
[Visual Studio Code]: <https://github.com/rubyide/vscode-ruby/issues/113#issuecomment-288667216>
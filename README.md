# Register
this is a project 
that resembles a register and login's website, with 
the aim of improving
my responsive web skills.


## Installation

before startup the server, you will 
need to created the `.env` on the **Register** and add the Constants:
* `DATABASE_USERNAME` and `DATABASE_PASSWORD`:
```yml
# config/database.yml 

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD']%>
  host: localhost
```
* `DEVELOPMENT_GMAIL` and `DEVELOPMENT_GMAIL_PASSWORD`:
```ruby
# config/environments/development.rb

config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                  587,
    user_name:            ENV['DEVELOPMENT_GMAIL'],
    password:             ENV['DEVELOPMENT_GMAIL_PASSWORD'],
    authentication:       'login',
    enable_starttls_auto: true, 
    open_timeout:         5,
    read_timeout:         5 
}

# and app/mailers/application_mailer.rb

class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEVELOPMENT_GMAIL']
  layout "mailer"
end

```
* `RECAPTCHA_SITE_KEY` and `RECAPTCHA_SECRETE_KEY`:

```ruby
# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
    config.site_key  = ENV['RECAPTCHA_SITE_KEY']
    config.secret_key = ENV['RECAPTCHA_SECRETE_KEY']
end

```

Then, put the `bundle install` on your terminal
to install the gems,
and after do migrate of the database, sartup the server.
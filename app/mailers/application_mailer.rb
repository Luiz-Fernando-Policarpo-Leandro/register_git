class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEVELOPMENT_GMAIL']
  layout "mailer"
end

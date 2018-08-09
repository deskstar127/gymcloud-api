class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_EMAIL']
  include InlineImages
  helper :mailer
end

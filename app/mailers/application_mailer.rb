class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@devschool.rocks"
  layout 'mailer'
end

class WelcomeMailer < ApplicationMailer
  ActionMailer::Base.mail(to: 'random@example.com', subject: 'Welcome!')
end

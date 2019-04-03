require "dry/transaction"

class CreateUser
  include Dry::Transaction

  step :create
  step :send_welcome_email

  def create(email:, first_name:, last_name:,
             date_of_birth:, password:, password_confirmation:)
    User.create(email: email, first_name: first_name,
                last_name: last_name, date_of_birth: date_of_birth,
                password: password, password_confirmation: password_confirmation)
  end

  def send_welcome_email
    WelcomeMailer.welcome.deliver_now
  end
end

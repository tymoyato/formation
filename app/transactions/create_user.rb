require "dry/transaction"

class CreateUser
  include Dry::Transaction

  step :create
  tee :send_email

  def create(input)
    if input[:user].save
      Success(input)
    else
      Failure(error: input[:user].errors.full_messages.join(', '))
    end
  end

  def send_email
    WelcomeMailer.welcome.deliver_now
  end
end

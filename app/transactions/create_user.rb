require "dry/transaction"

class CreateUser
  include Dry::Transaction

  tee :fetch_input
  step :create
  # tee :send_email

  def fetch_input(input)
    @email = input[:email]
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @date_of_birth = input[:date_of_birth]
    @password = input[:password]
    @password_confirmation = input[:password_confirmation]
  end

  def create
    user = User.new(email: @email,
                    first_name: @first_name,
                    last_name: @last_name,
                    date_of_birth: @date_of_birth,
                    password: @password,
                    password_confirmation: @password_confirmation)
    if user.save
      Success(user: user)
    else
      Failure(error: user.errors.full_messages.join(', '))
    end
  end

  # def send_email
  #   WelcomeMailer.welcome.deliver_now
  # end
end

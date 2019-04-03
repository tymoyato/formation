require "dry/transaction"

class CreateUser
  include Dry::Transaction

  tee :fetch_input
  step :create

  def fetch_input(input)
    @email = input.fetch(:email)
    @first_name = input.fetch(:first_name)
    @last_name = input.fetch(:last_name)
    @date_of_birth = input.fetch(:date_of_birth)
    @password = input.fetch(:password)
    @password_confirmation = input.fetch(:password_confirmation)
  end

  def create
    user = User.create(email: @email, first_name: @first_name,
                last_name: @last_name, date_of_birth: @date_of_birth,
                password: @password, password_confirmation: @password_confirmation)
    Success(user)
  end
end

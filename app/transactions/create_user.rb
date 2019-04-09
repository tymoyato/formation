require "dry/transaction"

class CreateUser
  include Dry::Transaction

  step :create

  def create(input)
    if input[:user].save
      Success(input)
    else
      Failure(error: input[:user].errors.full_messages.join(', '))
    end
  end
end

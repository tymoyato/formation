require "dry/transaction"

class CreateUser
  include Dry::Transaction

  step :create

  def create(user)
    if user.save
      Success(user: user)
    else
      Failure(error: user.errors.full_messages.join(', '))
    end
  end
end

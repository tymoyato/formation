require "dry/transaction"

class CreateContrepartie
  include Dry::Transaction

  step :create

  def create(input)
    if input[:contrepartie].save
      Success(input)
    else
      Failure(error: input[:contrepartie].errors.full_messages.join(', '), resource: input[:contrepartie])
    end
  end
end

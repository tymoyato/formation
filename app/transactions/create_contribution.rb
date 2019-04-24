require "dry/transaction"

class CreateContribution
  include Dry::Transaction

  step :create

  def create(input)
    if input[:contribution].save
      Success(input)
    else
      Failure(error: input[:contribution].errors.full_messages.join(', '), resource: input[:contribution])
    end
  end
end

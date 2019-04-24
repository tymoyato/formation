require "dry/transaction"

class CreateProject
  include Dry::Transaction

  step :create

  def create(input)
    if input[:project].save
      Success(input)
    else
      Failure(error: input[:project].errors.full_messages.join(', '), resource: input[:project])
    end
  end
end

require "dry/transaction"

class StartSuccess
  include Dry::Transaction

  step :success_transition

  def success_transition(input)
    if input[:project].succeed!
      Success(input)
    else
      Failure(error: input[:project].errors.full_messages.join(', '), resource: input[:project])
    end
  end
end

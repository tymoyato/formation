require "dry/transaction"

class StartUpcoming
  include Dry::Transaction

  step :upcoming_transition

  def upcoming_transition(input)
    if input[:project].coming!
      Success(input)
    else
      Failure(error: input[:project].errors.full_messages.join(', '), resource: input[:project])
    end
  end
end

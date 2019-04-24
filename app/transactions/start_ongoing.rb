require "dry/transaction"

class StartOngoing
  include Dry::Transaction

  step :ongoing_transition

  def ongoing_transition(input)
    if input[:project].going!
      Success(input)
    else
      Failure(error: input[:project].errors.full_messages.join(', '), resource: input[:project])
    end
  end
end

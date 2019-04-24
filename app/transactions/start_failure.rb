require "dry/transaction"

class StartFailure
  include Dry::Transaction

  step :failure_transition

  def failure_transition(input)
    if input[:project].failed!
      Success(input)
    else
      Failure(error: input[:project].errors.full_messages.join(', '), resource: input[:project])
    end
  end
end

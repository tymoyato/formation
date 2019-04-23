class PercentageSuccessValidator < BaseValidator
  validates_numericality_of :percentage, greater_than_or_equal_to: 100
end

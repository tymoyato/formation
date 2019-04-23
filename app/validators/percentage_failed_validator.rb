class PercentageFailedValidator < BaseValidator
  validates_numericality_of :percentage, less_than: 100
end

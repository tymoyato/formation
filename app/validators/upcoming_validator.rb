class UpcomingValidator < BaseValidator
  validates :name, presence: true
  validates :short_desc, presence: true
  validates :long_desc, presence: true
  validates :landscape, presence: true
  validates :thumb, presence: true
end

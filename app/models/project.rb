class Project < ApplicationRecord
  belongs_to :category
  has_many :contributions, dependent: :destroy
  has_many :contrepartie, dependent: :destroy
  has_many :users, through: :contributions

  validates :name, :amount, :category, presence: true
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)

  scope :by_on_draft, -> do
    Project.where(aasm_state: "draft")
  end

  scope :by_up_coming, -> do
    Project.where(aasm_state: "upcoming")
  end

  scope :by_on_going, -> do
    Project.where(aasm_state: "ongoing")
  end

  scope :by_on_success, -> do
    Project.where(aasm_state: "success")
  end

  scope :by_on_failure, -> do
    Project.where(aasm_state: "failure")
  end

  include AASM

  aasm :whiny_transitions => false do
    state :draft, initial: true
    state :upcoming
    state :ongoing
    state :success
    state :failure

    event :coming do
      transitions from: [:draft], to: :upcoming, guard: :upcoming_params
    end

    event :going do
      transitions from: [:upcoming], to: :ongoing, guard: :ongoing_params
    end

    event :succeed do
      transitions from: [:ongoing], to: :success, guard: :success_params
    end

    event :failed do
      transitions from: [:ongoing], to: :failure, guard: :failed_params
    end
  end

  def upcoming_params
    UpcomingValidator.new(self).valid?
  end

  def ongoing_params
    contrepartie.blank? ? false : true
  end

  def success_params
    PercentageSuccessValidator.new(self).valid?
  end

  def failed_params
    PercentageFailedValidator.new(self).valid?
  end

  def totalize_contributions
    contributions.sum(:amount)
  end

  def lower_contribution
    contributions.min_by(&:amount).amount
  end

  def higher_contribution
    contributions.max_by(&:amount).amount
  end

  def percentage_of_completion
    percent = (totalize_contributions.to_f / amount.to_f) * 100.0
    percent.round.to_s + " %"
  end
end

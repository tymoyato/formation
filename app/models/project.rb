class Project < ApplicationRecord
  belongs_to :category
  has_many :contributions, dependent: :destroy
  has_many :contrepartie, dependent: :destroy
  has_many :users, through: :contributions

  validates :name, :amount, presence: true
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)

  include AASM

  aasm :whiny_transitions => false do
    state :draft, initial: true
    state :upcoming
    state :ongoing
    state :success
    state :failure

    event :coming do
      transitions from: [:draft], to: :upcoming
    end

    event :going do
      transitions from: [:upcoming], to: :ongoing
    end

    event :succeed do
      transitions from: [:ongoing], to: :success
    end

    event :failed do
      transitions from: [:ongoing], to: :failure
    end
  end

  def totalize_contributions
    contributions = Contribution.where(project: id)
     @list = contributions.map do |project|
       project.amount
     end
    @list.sum
  end

  def lower_contribution
    @list.sort.first
  end

  def higher_contribution
    @list.sort.last
  end

  def percentage_of_completion
    percent = (totalize_contributions.to_f / amount.to_f) * 100.0
    percent.round.to_s + " %"
  end
end

class Project < ApplicationRecord
  belongs_to :category
  has_many :contributions, dependent: :destroy
  has_many :users, through: :contributions

  validates :name, :amount, presence: true
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)

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

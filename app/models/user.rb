class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :contributions
  has_many :projects, through: :contributions

  validates :first_name, :last_name, :date_of_birth, presence: true
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, uniqueness: true

  def full_name
    first_name + ' ' + last_name
  end
end

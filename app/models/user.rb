class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :prospects
    has_many :results, through: :prospects
  validates :username, presence: true, uniqueness: true
  def name
    "#{first_name} #{last_name}"
  end
end

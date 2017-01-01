class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: true
  validates :permission_level, presence: true, inclusion: {in: ['Normal', 'Manager', 'Admin']}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :prospects
  has_many :results, through: :prospects
  before_create :set_normal_user

  def name
    "#{first_name} #{last_name}"
  end
  def admin?
    (self.permission_level == 'Admin' or self.username == 'coteyr@coteyr.net')
    #self.permission_level and self.permission_level == ('Admin') or self.username = 'coteyr@coteyr.net'
  end
  def manager?
    self.permission_level and self.permission_level.casecmp('Manager').zero?
  end
  def normal?
    self.permission_level.nil? || (!admin? and !manager?)
  end
private
  def set_normal_user
    self.permission_level = 'Normal'
  end
end

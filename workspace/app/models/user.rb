class User < ApplicationRecord

  has_many :works, dependent: :destroy
  belongs_to :role
  has_many :freelancer_categories
  has_many :categories, through: :freelancer_categories
  has_many :joiners

#  accepts_nested_attributes_for  :freelancer_categories
  before_save { email.downcase! }
  validates :username,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, allow_blank: true, on: :update

   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
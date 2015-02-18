class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  before_validation :generate_slug

  validates :full_name, presence: true, length: { in: 5..100 },
  format: { with: /\A[a-z ,.'-]+\z/i,  message: "Incorrect name format" }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Invalid email" },
  uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :display_name, length: { in: 2..32 }, presence: true, uniqueness: true,
  format: { with: /\A[a-zA-Z0-9]+\z/, message: "Invalid Characters" }

  def admin?
    false
  end

  def generate_slug
    self.slug = display_name.parameterize
  end
end

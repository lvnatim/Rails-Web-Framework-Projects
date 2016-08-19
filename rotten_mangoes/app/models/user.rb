class User < ApplicationRecord

  has_secure_password

  paginates_per 10

  has_many :reviews, dependent: :destroy

  validates :email,
    presence: true

  validates :password,
    length: { in: 6..20 }, 
    on: :create

  scope :param_search, ->(search_term){ 
    where("firstname LIKE ? OR lastname LIKE ? OR email LIKE ? OR id LIKE ? COLLATE NOCASE", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  }

  def full_name
    "#{firstname} #{lastname}"
  end

  def is_admin?
    admin
  end

end

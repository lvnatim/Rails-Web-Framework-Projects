class Actor < ApplicationRecord
  has_and_belongs_to_many :movies
  has_many :reviews, through: :movies

  validates :name,
    presence: true

  validates :age,
    presence: true,
    numericality: {
      greater_than: 0
    }

  validates :gender,
    presence: true,
    format: {
      with: /(M|F)/,
      message: "must be in the format of either M or F"
    }
end

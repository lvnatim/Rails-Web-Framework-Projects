class Movie < ApplicationRecord

  UNDER_90_MINUTES = 1
  BETWEEN_90_AND_120 = 2
  OVER_120 = 3

  mount_uploader :poster, PosterUploader
  has_and_belongs_to_many :actors
  has_many :reviews
  has_many :categories

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: {only_integer: true}

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  # scope :filter_title, ->(title) {where("title LIKE ? COLLATE NOCASE", "%#{title}%")}
  # scope :filter_director, ->(director) {where("director LIKE ? COLLATE NOCASE", "%#{director}%")}
  scope :filter_title_or_director, ->(search_term) {where("title LIKE ? OR director LIKE ? COLLATE NOCASE", "%#{search_term}%", "%#{search_term}%")}
  scope :filter_runtime_in_minutes, ->(runtime_in_minutes) {
    case runtime_in_minutes.to_i
    when UNDER_90_MINUTES
      where("runtime_in_minutes < 90")
    when BETWEEN_90_AND_120
      where("runtime_in_minutes <= 120 AND runtime_in_minutes >= 90")
    when OVER_120
      where(" runtime_in_minutes > 120 ")
    end
  }

  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end

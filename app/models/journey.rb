class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :passengers
  has_one :pick_up_location, :class_name => "Location", :foreign_key => "pick_up_location_id"
  has_one :drop_off_location, :class_name => "Location", :foreign_key => "drop_off_location_id"
  validates :seats_available, presence: true, numericality: true, inclusion: {in: (1..7)}
  validates :pick_up_time, presence: true
  validates :pick_up_location, presence: true
  validates :drop_off_location, presence: true
  validate :journey_date_cannot_be_in_the_past

  def journey_date_cannot_be_in_the_past
    if pick_up_time < Date.today
      errors.add(:pick_up_time, "Cannot be in the past")
    end
  end

  geocoded_by :drop_off_location,
    latitude: :drop_off_latitude,
    longitude: :drop_off_longitude

  geocoded_by :pick_up_location,
    latitude: :pick_up_latitude,
    longitude: :pick_up_longitude


  after_validation :geocode, if: :one_location_changed?

  def one_location_changed?
    pick_up_location_changed? || drop_off_location_changed?
  end
end

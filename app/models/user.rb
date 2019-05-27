class User < ApplicationRecord
  has_many :addresses, as: :owner
  has_many :vehicles, foreign_key: 'owner_id'

  has_many :user_blocks
  has_many :blocked_users, through: :user_blocks

  has_many :carpools, foreign_key: 'driver_id'
  has_many :carpool_passengers
  has_many :rides, through: :carpool_passengers, class_name: :Carpool

  enum role: %i[default organizer admin]

  validates :email,
            presence: true,
            format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  def default_vehicle
    self.vehicles.find_by(default: true)
  end

  def needs_default?
    self.default_vehicle.nil?
  end

  def has_address?
    self.addresses.count > 0
  end

  def add_vehicle(params)
    Vehicle.create(params.merge({owner: self, default: needs_default?}))
  end
end

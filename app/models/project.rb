class Project < ApplicationRecord
  belongs_to :organizer, foreign_key: 'organizer_id', class_name: :User
  has_one :location, as: :owner, class_name: :address
  has_many :carpools

  def address
    Address.where(owner_id: id).first
  end
end

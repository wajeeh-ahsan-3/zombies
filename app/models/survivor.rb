class Survivor < ApplicationRecord
	#constants
	enum gender: [:male, :female]

	#validations
	validates_presence_of :name, :age, :gender, :latitude, :longitude
	validates :age , numericality: { greater_than_or_equal_to: 0 }
	validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
	validates :longitude , numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

	#relationships
	has_many :inventory_items
	accepts_nested_attributes_for :inventory_items

	#scopes
	scope :infected, -> { where(infected: true) }
	scope :not_infected, -> { where(infected: false) }
end

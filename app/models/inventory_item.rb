class InventoryItem < ApplicationRecord
  #relationships
  belongs_to :survivor
  belongs_to :item

  #callbacks
  before_create :validate_quantity
  after_initialize :set_quantity_default

  #scopes
  scope :for_infected, -> { includes(:item).joins(:survivor).where("survivors.infected = ?", true) }
  scope :for_not_infected, -> { includes(:item).joins(:survivor).where("survivors.infected = ?", false) }
  scope :not_finished, -> { where(quantity: 1..) }
  
  private
  
  def set_quantity_default
    self.quantity = 0 unless self.id.present?
  end

  def validate_quantity
    self.errors.add(:quantity, "Should be greater than 0") if self.quantity < 1
  end
end

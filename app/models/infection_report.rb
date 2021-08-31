class InfectionReport < ApplicationRecord
  #callbacks
  after_save :check_infection_count

  #relationships
  belongs_to :reporter, class_name: 'Survivor'
  belongs_to :survivor, class_name: 'Survivor'
  
  #validations 
  validates_with InfectionReportValidator

  private

  def check_infection_count
    count = InfectionReport.where(survivor: self.survivor).count
    if count > 4
      self.survivor.infected = true
      self.survivor.save
    end
  end
end

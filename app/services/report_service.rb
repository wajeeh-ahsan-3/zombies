class ReportService
    def create_report
			{
				non_infected_survivors_percentage: calculate_non_infected_survivors_percentage,
				infected_survivors_percentage: calcualte_infected_survivors_percentage,
				resource_average: calculate_resource_average,
				points_lost: check_points_lost
			}
    end

    private

    def calcualte_infected_survivors_percentage
      (Survivor.infected.count.to_f / Survivor.count * 100).round 2
    end

    def calculate_non_infected_survivors_percentage
      (Survivor.not_infected.count.to_f / Survivor.count * 100).round 2
    end

    def calculate_resource_average
			survivors = survivors_count
			resource_average = []
			InventoryItem.not_finished.for_not_infected.group(:item_id).sum(:quantity).each do |id, quantity|
					resource_average << {id: id, name: Item.find(id).name, average: (quantity.to_f/survivors).round(2)}
			end
			resource_average
    end

    def check_points_lost
			points_lost = 0
			InventoryItem.not_finished.for_infected.each do |inventory_item|
					points_lost = points_lost + inventory_item.quantity * inventory_item.item.points
			end
			points_lost
    end

    def survivors_count
      Survivor.where(infected: false).count
    end

end
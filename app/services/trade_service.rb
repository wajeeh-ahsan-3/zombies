class TradeService
  def make_barter_trade trade_params
    @trade_params = trade_params
    load_data_of_buyer_and_receiver
    is_tradeable?
    calc_trade
  end

  private

  def calc_trade
    ActiveRecord::Base.transaction do
      update_items_for @receiver, @buyer, receiver_items
      update_items_for @buyer, @receiver, buyer_items
    end
  end

  def update_items_for receiver, buyer, items
    items.each do |item|
      receiver_inventory_item = receiver.inventory_items.find_by item_id: item[:item_id]
      receiver_inventory_item.quantity -= item[:quantity]
      buyer_inventory_item = buyer.inventory_items.find_or_initialize_by item_id: item[:item_id]
      buyer_inventory_item.quantity += item[:quantity]
      receiver_inventory_item.save!
      buyer_inventory_item.save!
    end
  end

  def load_data_of_buyer_and_receiver
    @buyer = Survivor.find @trade_params[:buyer_id]
    @receiver = Survivor.find @trade_params[:receiver_id]
  end

  def is_tradeable?
    raise "Buyer and Receiver both will not be infected"  if @buyer.infected? || @receiver.infected
    raise "Buyer must trade with someone else"  if @buyer == @receiver
    raise "In Trade , both survivors must have items mentioned in trade"  if is_items_unavaiable?
    raise "In trade , Quantity of items will be valid for both."  if check_quantity_invalid?
    raise "In trade , Items will be of same value."  if are_points_different?
  end


  def are_points_different?
    points_for(buyer_items) != points_for(receiver_items)
  end

  def points_for items
    points = 0

    items.each do |inventory_item|
      item = Item.find inventory_item[:item_id]
      points += item.points * inventory_item[:quantity]
    end
    points
  end

  def is_items_unavaiable?
    (item_ids_check(buyer_items) - item_ids_owned(@buyer)).present? ||
    (item_ids_check(receiver_items) - item_ids_owned(@receiver)).present?
  end

  def item_ids_check items
    items.pluck :item_id
  end

  def check_quantity_valid_for? items, survivor
    valid = false
    items.each do |item|
      valid = survivor.inventory_items.where(item_id: item[:item_id], quantity: item[:quantity]..).nil?
      break unless valid
    end
    valid
  end

  def item_ids_owned survivor
    survivor.inventory_items.pluck :item_id
  end

  def check_quantity_invalid?
    check_quantity_valid_for?(buyer_items, @buyer) && check_quantity_valid_for?(receiver_items, @receiver)
  end

  def find_item id
    Item.find id
  end

  def buyer_items
    @trade_params[:buyer_items]
  end

  def receiver_items
    @trade_params[:receiver_items]
  end
end
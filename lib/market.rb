class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
    # binding.pry
    @date = Date.today
  end

  def date
    @date.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    items = @vendors.map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end.flatten
    items.uniq.sort
  end

  def total_inventory
    @vendors.inject({}) do |total_inventory, vendor|
      vendor.inventory.each do |item, quantity|
        total_inventory[item] = {quantity: 0, vendors: []} if total_inventory[item].nil?
        total_inventory[item][:quantity] += quantity
        total_inventory[item][:vendors] << vendor
        # binding.pry
      end
      total_inventory
    end
  end

  def overstocked_items
    item_infos = total_inventory.select do |item, info|
      info[:quantity] > 50 && info[:vendors].length > 1
    end
    item_infos.keys
  end

  def sell(item, quantity)
    return false if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
    vendor = @vendors.find do |vendor|
      vendor.check_stock(item) > 0
    end
    amount_sold = vendor.sell(item, quantity)
    remaining_quantity = quantity - amount_sold
    if remaining_quantity > 0
      sell(item, remaining_quantity)
    end
    return true
  end
end

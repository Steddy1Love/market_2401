require './lib/item'
require './lib/vendor'

RSpec.describe ClassName do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@vendor).to be_an_instance_of Vendor
    end

    it 'has attributes' do
        expect(@vendor.name).to eq("Rocky Mountain Fresh")
        expect(@vendor.inventory).to eq({})
    end
  end

  describe '#methods' do
    it 'can check stock and input stock' do
        expect(@vendor.check_stock(@item1)).to eq(0)
        
        @vendor.stock(@item1, 30)

        expect(@vendor.check_stock).to eq({@item1 => 30})
    end
  end
end
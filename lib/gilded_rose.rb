class Item
  attr_reader :name
  attr_accessor :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
end

class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    items.each do |item|
      case item.name
      when "Aged Brie"
        if item.sell_in <= 0
          item.quality += 2
        else
          item.quality += 1
        end

        if item.quality > 50
          item.quality = 50
        end

        item.sell_in -= 1
      when "Sulfuras, Hand of Ragnaros"
        item.quality -= 0
        item.sell_in -= 0
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in <= 0
          item.quality = 0
        elsif item.sell_in <= 5
          item.quality += 3
        elsif item.sell_in <= 10
          item.quality += 2
        else
          item.quality += 1
        end

        item.sell_in -= 1
      else
        if item.sell_in <= 0
          item.quality -= 2
        else
          item.quality -= 1
        end

        if item.quality < 0
          item.quality = 0
        end

        item.sell_in -= 1
      end
    end
  end
end

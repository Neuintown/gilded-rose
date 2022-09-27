require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/gilded_rose'

class GildedRoseTest < Minitest::Test

  def test_generic_item_quality_degrades_by_one
    items = [Item.new("foo", 3, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 4, items[0].quality
  end

  def test_generic_item_sellin_decreases_by_one
    items = [Item.new("foo", 3, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 2, items[0].sell_in
  end

  def test_generic_item_quality_degrades_twice_as_fast_after_sellin
    items = [Item.new("foo", 0, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 3, items[0].quality
  end

  def test_generic_item_quality_is_never_negative
    items = [Item.new("foo", 3, 0)]
    GildedRose.new(items).update_quality()
    assert_equal 0, items[0].quality
  end

  def test_aged_brine_quality_increases_by_one
    items = [Item.new("Aged Brie", 3, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 6, items[0].quality
  end

  def test_aged_brine_quality_increases_by_two_after_sellin
    items = [Item.new("Aged Brie", 0, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 7, items[0].quality
  end

  def test_aged_brine_quality_is_never_more_than_50
    items = [Item.new("Aged Brie", 3, 50)]
    GildedRose.new(items).update_quality()
    assert_equal 50, items[0].quality
  end

  def test_sulfuras_quality_never_degrades
    items = [Item.new("Sulfuras, Hand of Ragnaros", 3, 80)]
    GildedRose.new(items).update_quality()
    assert_equal 80, items[0].quality
  end

  def test_sulfuras_never_has_to_be_sold
    items = [Item.new("Sulfuras, Hand of Ragnaros", 3, 80)]
    GildedRose.new(items).update_quality()
    assert_equal 3, items[0].sell_in
  end

  def test_backstage_passes_quality_increases_by_one_when_more_than_10_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 6, items[0].quality
  end

  def test_backstage_passes_quality_increases_by_two_when_10_days_or_less
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 7, items[0].quality
  end

  def test_backstage_passes_quality_increases_by_three_when_5_days_or_less
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 8, items[0].quality
  end

  def test_backstage_passes_quality_drops_to_zero_after_concert
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 5)]
    GildedRose.new(items).update_quality()
    assert_equal 0, items[0].quality
  end
end

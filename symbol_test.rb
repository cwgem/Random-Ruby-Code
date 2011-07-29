require "test/unit"

class TestLibraryFileName < Test::Unit::TestCase
  def my_method
  end
  
  def test_symbol
    assert_equal true, Symbol.all_symbols.include?(:my_method)
  end
  
  def test_symbol2
    assert_equal true, Symbol.all_symbols.include?(:hoge)
  end
end
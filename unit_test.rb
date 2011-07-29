require "test/unit"

class MyClass
  attr_accessor :my_attribute
  
  def my_method
    "test"
  end
end

class TestLibraryFileName < Test::Unit::TestCase
  def test_method
    class_instance = MyClass.new
    assert_equal "test", class_instance.my_method
  end
  
  def test_attribute
    class_instance = MyClass.new
    assert_equal nil, class_instance.my_attribute
    
    class_instance.my_attribute = "test"
    assert_equal "test", class_instance.my_attribute
  end
end
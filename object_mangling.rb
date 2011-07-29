require "test/unit"

class ObjectMangling
  attr_accessor :seki
  def remove
    remove_instance_variable(:@seki)
  end
end

class TestLibraryFileName < Test::Unit::TestCase
  def test_remove_variable
    myclass = ObjectMangling.new
    myclass.seki = true
    myclass.remove
    assert_equal true, myclass.seki, "おめえの席ねぇから！！"
  end
end
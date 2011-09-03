def fib(n)
  return n if n < 2
  (2..n).inject([0,1]) { |memo|
    [memo[1],(memo[0]+memo[1])]
  }[1]
end

require "test/unit"

class TestFib < Test::Unit::TestCase
  def test_seed
    assert_equal(fib(0),0)
    assert_equal(fib(1),1)
  end

  def test_sequence
    assert_equal(fib(2),1)
    assert_equal(fib(3),2)
    assert_equal(fib(9),34)
    assert_equal(fib(14),377)
  end
end

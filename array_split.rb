require "test/unit"

class TestArraySplit < Test::Unit::TestCase
  def split(array,size)
   array.each_slice(size).inject(Array.new) { | final, x| final << x }
  end

  def split2(array,size,holder=Array.new,n=0)
   return holder if n >= array.length
   holder << array[n...(size+n)]
   split2 array, size, holder, size + n
  end

  def test_iter_method
    call_with_array_split :split
  end

  def test_recursive_method
    call_with_array_split :split2
  end

  def call_with_array_split(method)
    a = (1..10).to_a
    # even distribution
    assert_equal([[1,2],[3,4],[5,6],[7,8],[9,10]], self.send(method, a, 2))
    # uneven distribution
    assert_equal([[1,2,3],[4,5,6],[7,8,9],[10]], self.send(method, a, 3))
    # empty array
    assert_equal([],self.send(method, [], 3))
  end
end

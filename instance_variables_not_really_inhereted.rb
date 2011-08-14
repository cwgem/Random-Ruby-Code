class A
  def initialize
    p self
    @a = 1
  end
end

class B < A
  def initialize
    @b = 2
    super
  end

  def output
    puts "#@a #@b"
  end
end

obj = B.new
obj.output

# class TestClass
#  @test = 0 <-- self is TestClass
# 
#  def initialize(x)
#    @test = @test + x <-- WRONG! self is TestClass instance
#                          not TestClass itself!
#    puts "The result is #@test" <-- doesn't get reached due to
#                                    exception
#  end
#end

class TestClass
  @test = 0

  def initialize(x)
    @test = TestClass.instance_variable_get(:@test) + x
    puts "The result is: #{@test}"
  end
end

TestClass.new(1)

class MyObj

  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_s
    "#{@name} #{@age}"
  end

  def inspect
    "[MyObj] name: #{@name} age: #{@age}"
  end

end



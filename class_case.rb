class ClassCheck
  def initialize(*klass)
    @holder = klass
  end

  def ===(other)
    @holder.each { | klass |
      return true if klass == other
    }
    false
  end
end

klass = String

case klass
  when ClassCheck.new(Object, Numeric, String)
    puts "One of these"
  else
    puts "Nothing"
end

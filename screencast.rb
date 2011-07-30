class Screencast
  def inst_method
    puts "From instance method"
  end
  
  def create_method(name, &block)
    self.class.send(:define_method, name, &block)
  end  
  
  define_method :my_custom_instance, proc { puts "From another instance method" }
end

class Screencast
  class << self
    def mymethod
      puts "From singleton method"
    end

    def mymethod2
      puts "From other singleton method"
    end    
    
    def mymethod3
      puts "Yet another singleton method"
    end
  end
end

Screencast.define_singleton_method :my_custom_singleton, proc { puts "I love singletons!!" }

myinst = Screencast.new
myinst.create_method(:my_other_custom_instance) { puts "I love instance methods!!" }

p Screencast.instance_methods false

#myinst.my_custom_instance
#Screencast.my_custom_instance

# http://www.ruby-doc.org/core/classes/Object.html#M001040
# define_singleton_method

# http://www.ruby-doc.org/core/classes/Object.html#M001026
# singleton_methods

# http://ruby-doc.org/core/classes/Module.html#M000497
# define_method

# http://ruby-doc.org/core/classes/Module.html#M000480
# instance_methods
include ObjectSpace

class DestructorExample
  def initialize(name)
    define_finalizer self, proc { |id| puts "Instance #{name} Destroyed!" }
  end
end

define_finalizer DestructorExample, proc { |id| puts "Class Desroyed!" }

testing = DestructorExample.new(:test)
testing2 = DestructorExample.new(:test2)
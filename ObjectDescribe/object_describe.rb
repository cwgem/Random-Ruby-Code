module ObjectDescribe

  def self.output(object,supers={})
    # otherwise we have to pass this silly thing
    # around
    @object = object
    @output = String.new

    # use name method if a class, otherwise just use the name of the class +
    # Instance
    name = (@object.respond_to?(:name)) ? "#{@object.name}" : "#{@object.class} Instance"
    @output << name << "\n"
    @output << "=" * name.length << "\n"

    # Variables are important
    output_class_variables
    output_instance_variables

    # So are instance methods
    output_instance_methods(supers.key? :instance_supers)

    # Class methods are really instance methods of the meta class
    # or singleton methods if you will. However this only works if
    # the class of the object is Class.
    if object.class == Class
      output_class_methods(supers.key? :class_supers)    
    # However we still need to show the singleton methods if this
    # is not a direct instance of Class.
    else
      output_singleton_methods(supers.key? :singleton_supers)
    end

    @output
  end

  def self.output_class_methods(include_super)
    print_results :singleton_methods, "Class Methods", include_super
  end

  def self.output_instance_methods(include_super)
    print_results :instance_methods, "Instance Methods", include_super
  end

  def self.output_singleton_methods(include_super)
    print_results :singleton_methods, "Singleton Methods", include_super
  end

  def self.output_instance_variables
    print_results :instance_variables, "Instance Variables"
  end
  
  def self.output_class_variables
    print_results :class_variables, "Class Variables"
  end

  private

  def self.print_results(method, title, *args)

    # Class instances inherit the instance methods, so we need
    # to pull them from the class.
    if method == :instance_methods and @object.class != Class and @object.class != Module
      object = @object.class
    else
      object = @object
    end

    return if !object.respond_to? method

    results = object.send(method, *args)
    return if results.length == 0

    @output << "--#{title}" << "\n"
    results.each { | result |
      @output << "\t#{result}" << "\n"
    }
  end

end

if __FILE__ == $0
require 'yaml'

puts ObjectDescribe.output(YAML)
end

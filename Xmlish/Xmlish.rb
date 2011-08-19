require 'singleton'
require 'rexml/document'
require 'rexml/xpath'

class Xmlish
    include Singleton
    
    def self.get_me(xmlparser,&block)
      @parser = xmlparser
      @path = "/"

      if block_given?
        class_eval(&block)
      end

      return REXML::XPath.match(@parser,@path)
    end

    def self.all_the_elements(element,&block)
      @path << "/#{element}"
      if block_given?
        class_eval(&block)
      else
        return @path
      end
    end

    def self.with_children_where(element,&block)
      @path << "/#{element}"
      if block_given?
        class_eval(&block)
        @path << "/.."
      else
        return @path << "/.."
      end
    end

    def self.has_attribute_that_is(attribute,value,&block)
      @path << "[@#{attribute}='#{value}']"
      if block_given?
        class_eval(&block)
      else
        return @path
      end
    end
end

if __FILE__ == $0

doc = REXML::Document.new File.new("nutrition.xml")
foods = Xmlish.get_me(doc) do
  all_the_elements "food" do
    with_children_where "calories" do
     has_attribute_that_is "total", 110 
    end
  end
end

foods.each { | food |
  REXML::Formatters::Pretty.new(2).write(food, $stdout)
}

end

myobject = "test"

def myobject.mymethod
  puts "Hello World"
end

myobject.send(:mymethod)

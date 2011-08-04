require 'event_publisher.rb'

class MyPublisher
  include EventPublisher

  # Here we setup a list of events that
  # can be subscribed to
  def initialize
    events = [:hello]
    setup_events events
  end
  
  # An example method that produces the event
  def myevent
    puts "Publishing Event"
    publish_event :hello, "John Smith"
  end
end

# A sample subscribe class with a single method
# That handles the event
class MySubscriber
  def handle_hello_event(event,name)
    puts "#{event} handled: #{name}"
  end
end

def standard_method(event,name)
  puts "#{event} handled: #{name}"
end

publisher = MyPublisher.new
# Show the events available
p publisher.get_events

# Create the subscriber instance
subscriber = MySubscriber.new

# Use .method to retrieve a handle to the method instead
publisher.subscribe(:hello, subscriber.method(:handle_hello_event))

# You can use a standard method as well
publisher.subscribe(:hello, method(:standard_method))

publisher.myevent
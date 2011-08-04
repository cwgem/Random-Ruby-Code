require "test/unit"
require './event_publisher.rb'

def subscriber_method(event, *args)
	# use a global variable to get the test
	# results back to the Unit Test for assert_
	$test_result = [event,args]
end

class TestEventPublisher < Test::Unit::TestCase
        class MyEmptyEventPublisher
          include EventPublisher
          
          def initialize
            events = []
            setup_events events
          end
        end
        
        class MyEventPublisher
          include EventPublisher
          
          def initialize
            events = [:hello]
            setup_events events
          end
        end
        
        class MySubscriber
          attr_reader :result
          
          def handle_event(event, *args)
            @result = [event,args]
          end
        end
  
	def test_empty_events
          empty_event_publisher = MyEmptyEventPublisher.new
          
          assert_equal [], empty_event_publisher.get_events
          assert_equal false, empty_event_publisher.publish_event(:nothing,'test')
          
          subscriber = MySubscriber.new
          assert_equal false, empty_event_publisher.subscribe(:nothing, subscriber.method(:handle_event))
	end
	
	def test_single_event_no_subscribers
          event_publisher = MyEventPublisher.new
          
          assert_equal [:hello], event_publisher.get_events
          assert_equal true, event_publisher.publish_event(:hello, "Test")
	end
	
	def test_single_event_one_subscriber
          event_publisher = MyEventPublisher.new
          
          assert_equal [:hello], event_publisher.get_events
          
          subscriber = MySubscriber.new
          assert_equal true, event_publisher.subscribe(:hello, subscriber.method(:handle_event))
          assert_equal true, event_publisher.publish_event(:hello, "Test")
          assert_equal [:hello, ["Test"]], subscriber.result
	end
	
	def test_single_event_multiple_subscribers
          event_publisher = MyEventPublisher.new
          
          assert_equal [:hello], event_publisher.get_events
          
          subscriber1 = MySubscriber.new
          subscriber2 = MySubscriber.new
          assert_equal true, event_publisher.subscribe(:hello, subscriber1.method(:handle_event))
          assert_equal true, event_publisher.subscribe(:hello, subscriber2.method(:handle_event))
          assert_equal true, event_publisher.publish_event(:hello, "Test")
          assert_equal [:hello, ["Test"]], subscriber1.result
          assert_equal [:hello, ["Test"]], subscriber2.result
	end
	
	def test_non_class_method_subscriber
          event_publisher = MyEventPublisher.new
          
          assert_equal [:hello], event_publisher.get_events
          
          assert_equal true, event_publisher.subscribe(:hello, method(:subscriber_method))
          assert_equal true, event_publisher.publish_event(:hello, "Test")
          assert_equal [:hello, ["Test"]], $test_result
	end
end
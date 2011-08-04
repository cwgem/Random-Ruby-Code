module EventPublisher
  attr_reader :events
  attr_reader :subscribers
  
  def setup_events(events)
    @events = events
    @subscribers = {}
  end
  
  def get_events
    @events
  end
  
  def subscribe(event,handler)
    return false if ! @events.include? event
    @subscribers[event] = [] if @subscribers[event].nil?
    @subscribers[event] << handler
    true
  end
  
  def publish_event(event,*args)
    return false if ! @events.include? event
    return true if @subscribers[event].nil?
    
    @subscribers[event].each do |handler|
      handler.call event, *args
    end
    true
  end
end
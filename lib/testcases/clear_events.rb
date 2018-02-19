
class ClearEvents
  def execute
    ClearEvents::clear_events
  end
  
  ########################################################
  
  def self.clear_events
    vtn_parameter = VtnParameter.first

    ven = vtn_parameter.ven

    if ven.nil?
      raise "No test VEN found to clear events"
    end
    
    events = ven.events

    events.each do |event|
      event.destroy
    end

    ven.ven_messages.destroy_all
    
    ven.reload

    ven.generate_distribute_event_payload_value
    ven.save
  end
end


class QueueVenReregister
  def execute
    QueueVenReregister::reregister
  end
  
  ########################################################
  
  def self.reregister
    ven = VtnParameter.first.ven
    
    if ven.nil?
      raise "No test VEN found to reregister"
    end
      
    ven.reregister
  end
end

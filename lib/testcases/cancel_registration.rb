
class CancelRegistration
  def execute
    CancelRegistration::cancel_registration
  end
  
  ########################################################
  
  def self.cancel_registration
    ven = VtnParameter.first.ven
    
    if ven.nil?
      raise "No test VEN found to cancel registration"
    end
      
    ven.cancel_registration
  end
end

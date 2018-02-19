
class ClearRegistration
  def execute
    ClearRegistration::clear_registration
  end
  
  ########################################################
  
  def self.clear_registration
    ven = VtnParameter.first.ven
    
    if ven.nil?
      raise "No test VEN found to clear registration"
    end
      
    ven.clear_registration
    
    # also clear the registered reports
    ven.reports.each { |item| item.destroy }
  end
end

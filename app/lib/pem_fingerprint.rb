

class PemFingerprint
  def self.generate(pem_certificate)
    # replace spaces between "BEGIN CERTIFICATE" and "END CERTIFICATE" tags with 
    # newlines (apache replaces newlines with spaces before it sends the certification)
    first_space_index = pem_certificate.index(" ")
    last_space_index = pem_certificate.rindex(" ")
    
    # there is at least two spaces because of "BEGIN CERTIFICATE" and "END CERTIFICATE"
    if (first_space_index == last_space_index)
      raise "invalid pem format"
    end
    
    first_index = first_space_index + 1
    last_index = last_space_index - 1
    
    cert_text = pem_certificate[0..first_index] + pem_certificate[(first_index + 1)..last_index].tr(" ", "\n") + pem_certificate[(last_index + 1)..-1]
    
    # the proxy is configured to send the SSL_CLIENT_CERT parameter
    cert = OpenSSL::X509::Certificate.new(cert_text)
    
    # calculate the fingerprint
    fingerprint = OpenSSL::Digest::SHA1.new(cert.to_der).to_s
    
    # normalize the format of the fingerprint
    return PemFingerprint::normalize(fingerprint)
  end
  
  ########################################################

  def self.normalize(text)
    normalized_text = text.clone.to_s.downcase
    
    # remove colons
    normalized_text = normalized_text.gsub(/:/, "")
    
    # to make sure the fingerprint is correctly formatted with colons
    normalized_text = normalized_text.scan(/.{1,2}/).join(':')
    
    return normalized_text
  end
end

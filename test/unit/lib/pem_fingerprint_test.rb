
require 'test_helper'

require 'app/lib/pem_fingerprint.rb'

class PemFingerprintTest < ActiveSupport::TestCase
  test "pem to fingerprint" do
    expected_fingerprint = "8c:3e:7b:87:ab:46:3d:94:38:ca:cd:fc:d6:54:0c:cd:33:61:7b:8f"
    actual_fingerprint = PemFingerprint::generate(File.read("test/integration/input/cert.pem"))
    
    assert_equal(expected_fingerprint, actual_fingerprint)
  end
  
  ########################################################
  
  test "pem no newlines to fingerprint" do
    expected_fingerprint = "8c:3e:7b:87:ab:46:3d:94:38:ca:cd:fc:d6:54:0c:cd:33:61:7b:8f"
    actual_fingerprint = PemFingerprint::generate(File.read("test/integration/input/cert-newlines-to-spaces.pem"))
    
    assert_equal(expected_fingerprint, actual_fingerprint)
  end
  
  ########################################################
  
  test "pem no begin to fingerprint" do
    assert_raises(RuntimeError) { PemFingerprint::generate(File.read("test/integration/input/cert-no-begin.pem")) }
  end
end

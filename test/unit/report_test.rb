require File.dirname(__FILE__) + '/../test_helper'

require 'test/unit'
require 'mocha'
 
class ReportTest < Test::Unit::TestCase
  
  def test_publish  
    OBD::Report.expects(:publish).with("filename").returns(true)
    assert OBD::Report.publish("filename")
  end
  
end
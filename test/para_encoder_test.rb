require './test/test_helper'

class ParaEncoderTest < Minitest::Test

  def test_para_encoder_exists
    pe = ParaMorse::ParaEncoder.new
    assert pe
  end
  

end

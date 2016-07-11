require "minitest/autorun"
require "minitest/pride"
require "./paramorse"

class ParaTest < Minitest::Test
  def test_can_make_new_queue
    assert ParaMorse::Queue.new
  end
end

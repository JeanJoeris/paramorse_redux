require "SimpleCov"
SimpleCov.start
require "minitest/autorun"
require "minitest/pride"
require "./lib/paramorse"
class QueueTest < Minitest::Test
  def test_can_make_new_queue
    assert ParaMorse::Queue.new
  end

  def test_can_push_to_queue
    q = ParaMorse::Queue.new
    # puts q.methods - Object.new.methods
    q.push("1")
    assert_equal ["1"], q.queue
  end
end

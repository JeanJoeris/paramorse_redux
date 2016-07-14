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

  def test_queue_count
    q = ParaMorse::Queue.new
    assert_equal 0, q.count
    q.push("1")
    q.push("aardwolf")
    assert_equal 2, q.count
  end

  def test_can_pop_from_queue
    q = ParaMorse::Queue.new
    q.push("a")
    assert_equal "a", q.pop
  end

  def test_multi_pop
    q = ParaMorse::Queue.new
    q.push("a")
    q.push("b")
    assert_equal "ab".chars, q.pop(2)
  end

  def test_clear_queue
    q = ParaMorse::Queue.new
    q.push("badger")
    q.push("aardwolf")
    q.clear
    assert_equal [], q.queue
  end

  def test_tail_method
    q = ParaMorse::Queue.new
    q.push("1")
    q.push("1")
    q.push("0")
    assert_equal "1", q.peek
    assert_equal ["1", "1"], q.peek(2)
    assert_equal ["1", "1", "0"], q.peek(3)
  end

  def test_peek_method
    q = ParaMorse::Queue.new
    q.push("badger")
    q.push("1")
    q.push("0")
    assert_equal "0", q.tail
    assert_equal ["0", "1"], q.tail(2)
    assert_equal ["0", "1", "badger"], q.tail(3)
  end
end

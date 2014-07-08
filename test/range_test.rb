require File.expand_path('../test_helper', __FILE__)

class RangeTest < ParseTestCase

  test 'inclusive' do
    ruby 'foo..bar'
    assert_valid_child_expression RangeMatcher.new(ruby, CallMatcher.new('foo'), CallMatcher.new('bar'), true)
  end

  test 'exclusive' do
    ruby 'foo...bar'
    assert_valid_child_expression RangeMatcher.new(ruby, CallMatcher.new('foo'), CallMatcher.new('bar'), false)
  end

end
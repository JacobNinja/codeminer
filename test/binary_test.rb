require File.expand_path('./../test_helper', __FILE__)

class BinaryTest < ParseTestCase

  test '&&' do
    ruby 'foo && bar'
    assert_valid_child_expression BinaryMatcher.new('&&', CallMatcher.new('foo', 'foo'), CallMatcher.new('bar', 'bar'), ruby)
  end

  test '||' do
    ruby 'foo || bar'
    assert_valid_child_expression BinaryMatcher.new('||', CallMatcher.new('foo', 'foo'), CallMatcher.new('bar', 'bar'), ruby)
  end

  test '+' do
    ruby 'foo + bar'
    assert_valid_child_expression BinaryMatcher.new('+', CallMatcher.new('foo', 'foo'), CallMatcher.new('bar', 'bar'), ruby)
  end

end
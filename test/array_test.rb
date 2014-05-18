require File.expand_path('./../test_helper', __FILE__)

class ArrayTest < ParseTestCase

  test 'empty array' do
    ruby '[]'
    assert_valid_child_expression ArrayMatcher.new(ruby)
  end

  test 'array with content' do
    ruby '[1, 2]'
    assert_valid_child_expression ArrayMatcher.new(ArgumentsMatcher.new(Matcher.new(:int, '1', '1'), Matcher.new(:int, '2', '2'), '1, 2'), ruby)
  end

end
require File.expand_path('../test_helper', __FILE__)

class RegularExpressionTest < ParseTestCase

  test 'regular expression' do
    ruby '/foo/'
    assert_valid_child_expression RegexpMatcher.new(StringMatcher.new('foo', 'foo'), ruby)
  end

  test 'dynamic regular expression' do
    ruby '/foo[#{bar}]/'
    assert_valid_child_expression RegexpMatcher.new(StringMatcher.new('foo[', 'foo['), DynamicStringMatcher.new(CallMatcher.new('bar', 'bar'), '#{bar}'), StringMatcher.new(']', ']'), ruby)
  end

end
require File.expand_path('./../test_helper', __FILE__)

class ArgumentsTest < ParseTestCase

  test 'integer arguments' do
    ruby 'foo[1, 2]'
    assert_valid_child_expression ArgumentsMatcher.new(Matcher.new(:int, '1', '1'), Matcher.new(:int, '2', '2'), '1, 2'), 3
  end

end
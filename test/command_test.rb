require File.expand_path('../test_helper', __FILE__)

class CommandTest < ParseTestCase

  test 'command' do
    ruby 'foo -1'
    assert_valid_child_expression CommandMatcher.new('foo', ArgumentsMatcher.new(UnaryMatcher.new('-', Matcher.new(:int, '1'), '-1'), '-1'), ruby)
  end

  test 'command call' do
    ruby 'foo.undef_method :bar'
    assert_valid_child_expression CommandMatcher.new('undef_method', ArgumentsMatcher.new(Matcher.new(:symbol, 'bar', ':bar'), ':bar'), ruby, receiver: CallMatcher.new('foo', 'foo'))
  end

end
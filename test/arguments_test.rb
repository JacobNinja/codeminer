require File.expand_path('./../test_helper', __FILE__)

class ArgumentsTest < ParseTestCase

  test 'positional method params' do
    ruby <<-RUBY
def foo(a, b, c)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new(PositionalParamsMatcher.new(%w(a b c), 'a, b, c'), EmptyParamsMatcher, '(a, b, c)'), 3
  end

  test 'positional optional params' do
    ruby <<-RUBY
def foo(a=foo)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new(EmptyParamsMatcher, OptionalParamsMatcher.new('a=foo', a: CallMatcher.new('foo', 'foo')), '(a=foo)'), 3
  end

end
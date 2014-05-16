require File.expand_path('./../test_helper', __FILE__)

class ParamsTest < ParseTestCase

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

  test 'bare params' do
    ruby <<-RUBY
def foo a
end
    RUBY
    debug
    assert_valid_child_expression DefnMatcher.new('foo', ruby, params: ParamsMatcher.new(PositionalParamsMatcher.new(['a'], 'a'), EmptyParamsMatcher, 'a'))
  end

end
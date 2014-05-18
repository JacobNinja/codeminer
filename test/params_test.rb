require File.expand_path('./../test_helper', __FILE__)

class ParamsTest < ParseTestCase

  test 'positional method params' do
    ruby <<-RUBY
def foo(a, b, c)
end
    RUBY
    positionals = %w(a b c).map { |i| Matcher.new(:positional_param, i) }
    assert_valid_child_expression ParamsMatcher.new(PositionalParamsMatcher.new(*positionals, 'a, b, c'), EmptyParamsMatcher, '(a, b, c)'), 3
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
    assert_valid_child_expression DefnMatcher.new('foo', ruby, params: ParamsMatcher.new(PositionalParamsMatcher.new(Matcher.new(:positional_param, 'a'), 'a'), EmptyParamsMatcher, 'a'))
  end

  test 'destructured params' do
    ruby <<-RUBY
def test((foo, bar), baz)
end
    RUBY
    debug
    assert_valid_child_expression ParamsMatcher.new(PositionalParamsMatcher.new(DestructuredParamsMatcher.new(Matcher.new(:destructured_param, 'foo'), Matcher.new(:destructured_param, 'bar'), '(foo, bar)'), Matcher.new(:positional_param, 'baz'), '(foo, bar), baz'), '((foo, bar), baz)'), 3
  end

end
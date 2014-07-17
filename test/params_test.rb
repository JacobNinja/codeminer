require File.expand_path('./../test_helper', __FILE__)

class ParamsTest < ParseTestCase

  test 'positional method params' do
    ruby <<-RUBY
def foo(a, b, c)
end
    RUBY
    positionals = %w(a b c).map { |i| Matcher.new(:positional_param, i) }
    assert_valid_child_expression ParamsMatcher.new('(a, b, c)', PositionalParamsMatcher.new(*positionals, 'a, b, c')), 3
  end

  test 'positional optional params' do
    ruby <<-RUBY
def foo(a=foo)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('(a=foo)', EmptyParamsMatcher, OptionalParamsMatcher.new('a=foo', a: CallMatcher.new('foo', 'foo'))), 3
  end

  test 'bare params' do
    ruby <<-RUBY
def foo a
end
    RUBY
    assert_valid_child_expression DefnMatcher.new('foo', ruby, params: ParamsMatcher.new('a', PositionalParamsMatcher.new(Matcher.new(:positional_param, 'a'), 'a')))
  end

  test 'destructured params' do
    ruby <<-RUBY
def test((foo, bar), baz)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('((foo, bar), baz)', PositionalParamsMatcher.new(DestructuredParamsMatcher.new(Matcher.new(:destructured_param, 'foo'), Matcher.new(:destructured_param, 'bar'), '(foo, bar)'), Matcher.new(:positional_param, 'baz'), '(foo, bar), baz')), 3
  end

  test 'keyword params' do
    ruby <<-RUBY
def test(a: 1)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('(a: 1)', EmptyParamsMatcher, EmptyParamsMatcher, KeywordParamsMatcher.new('a: 1', a: Matcher.new(:int, '1'))), 3
  end

  test 'mandatory keyword param' do
    ruby <<-RUBY
def test(a:)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('(a:)', EmptyParamsMatcher, EmptyParamsMatcher, KeywordParamsMatcher.new('a:', a: NilMatcher)), 3
  end

  test 'splat param' do
    ruby <<-RUBY
def test(*bar)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('(*bar)', EmptyParamsMatcher, splat: Matcher.new(:splat, 'bar', '*bar')), 3
  end

  test 'block param' do
    ruby <<-RUBY
def test(&foo)
end
    RUBY
    assert_valid_child_expression ParamsMatcher.new('(&foo)', EmptyParamsMatcher, block: Matcher.new(:block_param, 'foo', '&foo')), 3
  end

end
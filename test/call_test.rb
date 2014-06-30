require File.expand_path('./../test_helper', __FILE__)

class CallTest < ParseTestCase

  test 'call with no receiver' do
    ruby <<-RUBY
foo()
    RUBY
    assert_valid_child_expression CallMatcher.new('foo', ruby)
  end

  test 'call with receiver' do
    ruby <<-RUBY
foo.bar()
    RUBY
    assert_valid_child_expression CallMatcher.new('bar', ruby, receiver: CallMatcher.new('foo', 'foo'))
  end

  test 'method block' do
    ruby <<-RUBY
foo { bar() }
    RUBY
    assert_valid_child_expression CallWithBlockMatcher.new('foo', BlockMatcher.new(<<-RUBY, CallMatcher.new('bar', 'bar()')), ruby)
{ bar() }
    RUBY
  end

  test 'method block do' do
    ruby <<-RUBY
foo do
  bar()
end
    RUBY
    assert_valid_child_expression CallWithBlockMatcher.new('foo', BlockMatcher.new(<<-RUBY, CallMatcher.new('bar', 'bar()')), ruby)
do
  bar()
end
    RUBY
  end

  test 'method block with params' do
    ruby <<-RUBY
foo do |bar|
  baz()
end
    RUBY
    params_matcher = ParamsMatcher.new('bar', PositionalParamsMatcher.new(Matcher.new(:positional_param, 'bar'), 'bar'))
    assert_valid_child_expression CallWithBlockMatcher.new('foo', BlockMatcher.new(<<-RUBY, CallMatcher.new('baz', 'baz()'), params_matcher: params_matcher), ruby)
do |bar|
  baz()
end
    RUBY
  end

  test 'bracket invocation' do
    ruby 'foo[bar]'
    assert_valid_child_expression CallMatcher.new('[', ruby, receiver: CallMatcher.new('foo', 'foo'), arguments: ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'))
  end

  test 'dot syntax' do
    ruby 'foo.(bar)'
    assert_valid_child_expression CallMatcher.new('call', ruby, receiver: CallMatcher.new('foo', 'foo'), arguments: ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), '(bar)'))
  end

end
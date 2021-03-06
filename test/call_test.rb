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
    assert_valid_child_expression CallMatcher.new('foo', ruby, block: BlockMatcher.new(<<-RUBY, CallMatcher.new('bar', 'bar()')))
{ bar() }
    RUBY
  end

  test 'method block do' do
    ruby <<-RUBY
foo.each do
  bar()
end
    RUBY
    assert_valid_child_expression CallMatcher.new('each', ruby, receiver: CallMatcher.new('foo', 'foo'), block: BlockMatcher.new(<<-RUBY, CallMatcher.new('bar', 'bar()')))
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
    assert_valid_child_expression CallMatcher.new('foo', ruby, block: BlockMatcher.new(<<-RUBY, CallMatcher.new('baz', 'baz()'), params_matcher: params_matcher))
do |bar|
  baz()
end
    RUBY
  end

  test 'arg with block' do
    ruby <<-RUBY
foo(&bar{ baz })
    RUBY
    assert_valid_child_expression ArgumentsMatcher.new('(&bar{ baz })', block: CallMatcher.new('bar', 'bar{ baz }', block: BlockMatcher.new('{ baz }', CallMatcher.new('baz')))), 3
  end

  test 'bracket invocation' do
    ruby 'foo[bar]'
    assert_valid_child_expression CallMatcher.new('[', ruby, receiver: CallMatcher.new('foo', 'foo'), arguments: ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'))
  end

  test 'dot syntax' do
    ruby 'foo.(bar)'
    assert_valid_child_expression CallMatcher.new('call', ruby, receiver: CallMatcher.new('foo', 'foo'), arguments: ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), '(bar)'))
  end

  test 'newline' do
    ruby <<-RUBY
foo
  .bar
    RUBY
    assert_valid_child_expression CallMatcher.new('bar', ruby, receiver: CallMatcher.new('foo', 'foo'))
  end

end
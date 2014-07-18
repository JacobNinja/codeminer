require File.expand_path('../test_helper', __FILE__)

class CodeMinerParseTest < ParseTestCase

  test 'root' do
    ruby <<-RUBY
# comment
    RUBY
    assert_valid_root_expression RootMatcher.new(ruby)
  end

  test 'return' do
    ruby 'return foo'
    assert_valid_child_expression ReturnMatcher.new(ArgumentsMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), ruby)
  end

  test 'return implicit nil' do
    ruby 'return'
    assert_valid_child_expression ReturnMatcher.new(NilMatcher, ruby)
  end

  test 'yield' do
    ruby 'yield foo'
    assert_valid_child_expression YieldMatcher.new(ArgumentsMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), ruby)
  end

  test 'yield implicit nil' do
    ruby 'yield'
    assert_valid_child_expression YieldMatcher.new(NilMatcher, ruby)
  end

  test 'integer' do
    ruby '1'
    assert_valid_child_expression Matcher.new(:int, '1', '1')
  end

  test 'unary' do
    ruby '-1'
    assert_valid_child_expression UnaryMatcher.new('-', Matcher.new(:int, '1', '1'), ruby)
  end

  test 'alias' do
    ruby 'alias foo bar'
    assert_valid_child_expression AliasMatcher.new(Matcher.new(:symbol, 'foo', 'foo'), Matcher.new(:symbol, 'bar', 'bar'), ruby)
  end

  test 'break' do
    ruby 'break'
    assert_valid_child_expression BreakMatcher.new(ArgumentsMatcher.new(''), ruby)
  end

  test 'next' do
    ruby 'next'
    assert_valid_child_expression NextMatcher.new(ArgumentsMatcher.new(''), ruby)
  end

  test 'super' do
    ruby 'super'
    assert_valid_child_expression Matcher.new(:super, nil, ruby)
  end

  test 'super with args' do
    ruby 'super foo'
    assert_valid_child_expression SuperMatcher.new(ArgumentsMatcher.new(CallMatcher.new('foo'), 'foo'), ruby)
  end

  test 'begin' do
    ruby <<-RUBY
begin
  foo
end
    RUBY
    assert_valid_child_expression BeginMatcher.new(ruby, BodyMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'))
  end

  test 'begin rescue' do
    ruby <<-RUBY
begin
  foo
rescue
  bar
end
    RUBY
    assert_valid_child_expression BeginMatcher.new(ruby, BodyMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), rescue_matcher: RescueMatcher.new(<<-RESCUE, NilMatcher, RescueBodyMatcher.new(CallMatcher.new('bar', 'bar'), 'bar')))
rescue
  bar
    RESCUE
  end

  test 'begin ensure' do
    ruby <<-RUBY
begin
  foo
ensure
  bar
end
    RUBY
    assert_valid_child_expression BeginMatcher.new(ruby, BodyMatcher.new(CallMatcher.new('foo'), 'foo'), ensure_matcher: EnsureMatcher.new(<<-ENSURE, BodyMatcher.new(CallMatcher.new('bar'), 'bar')))
ensure
  bar
    ENSURE
  end

  test 'lambda' do
    ruby '-> (arg) { foo }'
    assert_valid_child_expression LambdaMatcher.new(ParamsMatcher.new('(arg)', PositionalParamsMatcher.new(Matcher.new(:positional_param, 'arg'), 'arg')), BodyMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), ruby)
  end

  test 'redo' do
    ruby 'redo'
    assert_valid_child_expression Matcher.new(:redo, nil, 'redo')
  end

  test 'retry' do
    ruby 'retry'
    assert_valid_child_expression Matcher.new(:retry, nil, 'retry')
  end

  test 'undef' do
    ruby 'undef :foo, :bar'
    assert_valid_child_expression UndefMatcher.new(Matcher.new(:symbol, 'foo', ':foo'), Matcher.new(:symbol, 'bar', ':bar'), ruby)
  end

  test 'constant' do
    ruby 'Exception'
    assert_valid_child_expression Matcher.new(:constant, 'Exception')
  end

  test 'nil' do
    ruby 'nil'
    assert_valid_child_expression Matcher.new(:nil, nil, 'nil')
  end

  test 'self' do
    ruby 'self'
    assert_valid_child_expression Matcher.new(:self, nil, 'self')
  end

  test '||=' do
    ruby 'foo ||= bar'
    assert_valid_child_expression OpAssignMatcher.new('foo', CallMatcher.new('bar'), ruby)
  end

  test 'false' do
    ruby 'false'
    assert_valid_child_expression Matcher.new(:false, nil, ruby)
  end

  test 'true' do
    ruby 'true'
    assert_valid_child_expression Matcher.new(:true, nil, ruby)
  end

  test 'defined?' do
    ruby 'defined? foo'
    assert_valid_child_expression DefinedMatcher.new(CallMatcher.new('foo'), ruby)
  end

  test 'malformed statement' do
    assert_raise(CodeMiner::ParseError) { CodeMiner.parse(<<-RUBY) }
case
when something.end_with? foo
  "bar"
end
    RUBY
  end

  test 'compile error' do
    assert_raise(CodeMiner::ParseError) { CodeMiner.parse(<<-RUBY) }
%q
    RUBY
  end

end
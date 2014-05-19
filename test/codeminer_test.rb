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

  test 'begin' do
    ruby <<-RUBY
begin
  foo
end
    RUBY
    assert_valid_child_expression BeginMatcher.new(ruby, BodyMatcher.new(CallMatcher.new('foo', 'foo')))
  end

  test 'rescue' do
    ruby <<-RUBY
begin
  foo
rescue
  bar
end
    RUBY
    assert_valid_child_expression BeginMatcher.new(ruby, BodyMatcher.new(CallMatcher.new('foo', 'foo')), rescue_matcher: RescueMatcher.new(<<-RESCUE, BodyMatcher.new(CallMatcher.new('bar', 'bar'))))
rescue
  bar
    RESCUE
  end

  test 'command' do
    ruby 'foo -1'
    debug
    assert_valid_child_expression CommandMatcher.new('foo', ArgumentsMatcher.new(UnaryMatcher.new('-', Matcher.new(:int, '1'), '-1'), '-1'), ruby)
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
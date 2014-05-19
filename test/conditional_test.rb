require File.expand_path('../test_helper', __FILE__)

class ConditionalTest < ParseTestCase

  test 'inline if statement' do
    ruby 'foo if bar'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('bar', 'bar'), CallMatcher.new('foo', 'foo'), NilMatcher, ruby)
  end

  test 'inline unless statement' do
    ruby 'foo unless bar'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('bar', 'bar'), NilMatcher, CallMatcher.new('foo', 'foo'), ruby)
  end

  test 'if statement' do
    ruby <<-RUBY
if foo
  bar
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar', 'bar')), NilMatcher, ruby)
  end

  test 'if and else statement' do
    ruby <<-RUBY
if foo
  bar
else
  baz
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar', 'bar')), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz')), <<-ELSE), ruby)
else
  baz
    ELSE
  end

  test 'unless statement' do
    ruby <<-RUBY
unless foo
  bar
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), NilMatcher, BodyMatcher.new(CallMatcher.new('bar', 'bar')), ruby)
  end

  test 'unless with else statement' do
    ruby <<-RUBY
unless foo
  bar
else
  baz
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz')), <<-ELSE), BodyMatcher.new(CallMatcher.new('bar', 'bar')), ruby)
else
  baz
    ELSE
  end

  test 'ternary' do
    ruby 'foo ? bar : baz'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), CallMatcher.new('bar', 'bar'), CallMatcher.new('baz', 'baz'), ruby)
  end

  test 'conditional' do
    ruby <<-RUBY
case foo
when bar then 5
else baz
end
    RUBY
    debug
    assert_valid_child_expression CaseMatcher.new(ruby, CallMatcher.new('foo', 'foo'), WhenMatcher.new(ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), BodyMatcher.new(Matcher.new(:int, '5')), 'when bar then 5'), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz')), 'else baz'))
  end

end
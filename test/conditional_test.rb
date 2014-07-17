require File.expand_path('../test_helper', __FILE__)

class ConditionalTest < ParseTestCase

  test 'inline if statement' do
    ruby 'foo if bar'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), NilMatcher, ruby)
  end

  test 'inline unless statement' do
    ruby 'foo unless bar'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('bar', 'bar'), NilMatcher, BodyMatcher.new(CallMatcher.new('foo', 'foo'), 'foo'), ruby)
  end

  test 'if statement' do
    ruby <<-RUBY
if foo
  bar
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), NilMatcher, ruby)
  end

  test 'if and else statement' do
    ruby <<-RUBY
if foo
  bar
else
  baz
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz'), 'baz'), <<-ELSE), ruby)
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
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), NilMatcher, BodyMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), ruby)
  end

  test 'unless with else statement' do
    ruby <<-RUBY
unless foo
  bar
else
  baz
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz'), 'baz'), <<-ELSE), BodyMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), ruby)
else
  baz
    ELSE
  end

  test 'ternary' do
    ruby 'foo ? bar : baz'
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar'), 'bar'), BodyMatcher.new(CallMatcher.new('baz'), 'baz'), ruby)
  end

  test 'case' do
    ruby <<-RUBY
case foo
when bar then 5
when something then 6
else baz
end
    RUBY
    assert_valid_child_expression CaseMatcher.new(ruby, CallMatcher.new('foo', 'foo'), WhenMatcher.new(ArgumentsMatcher.new(CallMatcher.new('bar', 'bar'), 'bar'), BodyMatcher.new(Matcher.new(:int, '5'), '5'), 'when bar then 5'), WhenMatcher.new(ArgumentsMatcher.new(CallMatcher.new('something'), 'something'), BodyMatcher.new(Matcher.new(:int, '6'), '6'), 'when something then 6'), ElseMatcher.new(BodyMatcher.new(CallMatcher.new('baz', 'baz'), 'baz'), 'else baz'))
  end

  test 'elsif' do
    ruby <<-RUBY
if foo
  1
elsif bar
  2
else
  3
end
    RUBY
    else_src = <<-RUBY
else
  3
    RUBY
    elsif_matcher = ConditionalMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(Matcher.new(:int, '2'), '2'), ElseMatcher.new(BodyMatcher.new(Matcher.new(:int, '3'), '3'), else_src), <<-RUBY)
elsif bar
  2
else
  3
end
    RUBY
    assert_valid_child_expression ConditionalMatcher.new(CallMatcher.new('foo', 'foo'), BodyMatcher.new(Matcher.new(:int, '1'), '1'), elsif_matcher, ruby)
  end

end
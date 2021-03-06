require File.expand_path('./../test_helper', __FILE__)

class LoopTest < ParseTestCase

  test 'until' do
    ruby <<-RUBY
until bar
  foo()
end
    RUBY
    assert_valid_child_expression UntilMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(CallMatcher.new('foo', 'foo()'), 'foo()'), ruby)
  end

  test 'until mod' do
    ruby 'foo until bar'
    assert_valid_child_expression UntilMatcher.new(CallMatcher.new('bar', 'bar'), CallMatcher.new('foo', 'foo'), ruby)
  end

  test 'while' do
    ruby <<-RUBY
while bar
  foo()
end
    RUBY
    assert_valid_child_expression WhileMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(CallMatcher.new('foo', 'foo()'), 'foo()'), ruby)
  end

  test 'while mod' do
    ruby 'foo while bar'
    assert_valid_child_expression WhileMatcher.new(CallMatcher.new('bar', 'bar'), CallMatcher.new('foo', 'foo'), ruby)
  end

  test 'for' do
    ruby <<-RUBY
for i in foo
  bar(i)
end
    RUBY
    assert_valid_child_expression ForMatcher.new(PositionalParamsMatcher.new(LocalVariableMatcher.new('i'), 'i'), CallMatcher.new('foo', 'foo'), BodyMatcher.new(CallMatcher.new('bar', 'bar(i)', arguments: ArgumentsMatcher.new(LocalVariableMatcher.new('i'), '(i)')), 'bar(i)'), ruby)
  end

  test 'for multiple params' do
    ruby <<-RUBY
for a, b in foo
end
    RUBY
    assert_valid_child_expression ForMatcher.new(DestructuredParamsMatcher.new(LocalVariableMatcher.new('a'), LocalVariableMatcher.new('b'), 'a, b'), CallMatcher.new('foo', 'foo'), BodyMatcher.new(''), ruby)
  end

end
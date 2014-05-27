require File.expand_path('./../test_helper', __FILE__)

class LoopTest < ParseTestCase

  test 'until' do
    ruby <<-RUBY
until bar
  foo()
end
    RUBY
    assert_valid_child_expression UntilMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(CallMatcher.new('foo', 'foo()')), ruby)
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
    assert_valid_child_expression WhileMatcher.new(CallMatcher.new('bar', 'bar'), BodyMatcher.new(CallMatcher.new('foo', 'foo()')), ruby)
  end

  test 'while mod' do
    ruby 'foo while bar'
    assert_valid_child_expression WhileMatcher.new(CallMatcher.new('bar', 'bar'), CallMatcher.new('foo', 'foo'), ruby)
  end

end
require File.expand_path('../test_helper', __FILE__)

class MethodTest < ParseTestCase

  test 'global method' do
    ruby <<-RUBY
def foo
  bar
end
    RUBY
    assert_valid_child_expression DefnMatcher.new('foo', ruby)
  end

  test 'method with local variables' do
    ruby <<-RUBY
def foo
  bar = baz
end
    RUBY
    assert_valid_child_expression AssignmentMatcher.new('bar', CallMatcher.new('baz', 'baz'), 'bar = baz'), 4
  end

  test 'method on singleton' do
    ruby <<-RUBY
def a.foo
  bar()
end
    RUBY
    assert_valid_child_expression DefsMatcher.new('a', 'foo', ruby)
  end

  test 'rescue' do
    ruby <<-RUBY
def foo
  bar
rescue Exception => e
  baz
end
    RUBY
    assert_valid_child_expression RescueMatcher.new(<<-RESCUE, RescueMatchMatcher.new('Exception => e', LocalVariableMatcher.new('e'), Matcher.new(:constant, 'Exception')), RescueBodyMatcher.new(CallMatcher.new('baz'), 'baz')), 4
rescue Exception => e
  baz
    RESCUE
  end

  test 'rescue multiple constants' do
    ruby <<-RUBY
def foo
  bar
rescue Exception, RuntimeError => e
  baz
end
    RUBY
    assert_valid_child_expression RescueMatcher.new(<<-RESCUE, RescueMatchMatcher.new('Exception, RuntimeError => e', LocalVariableMatcher.new('e'), Matcher.new(:constant, 'Exception'), Matcher.new(:constant, 'RuntimeError')), RescueBodyMatcher.new(CallMatcher.new('baz'), 'baz')), 4
rescue Exception, RuntimeError => e
  baz
    RESCUE
  end

end
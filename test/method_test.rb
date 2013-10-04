require File.expand_path('../test_helper', __FILE__)

class MethodTest < ParseTestCase

  test 'global method' do
    ruby <<-RUBY
def foo
  bar
end
    RUBY
    assert_valid_expression DefnMatcher.new('foo', ruby)
  end

  test 'method with local variables' do
    ruby <<-RUBY
def foo
  bar = baz
end
    RUBY
  assert_valid_child_expression Matcher.new(:lasgn, 'bar', <<-EXPECTED)
  bar = baz
    EXPECTED
  end

  test 'method on singleton' do
    ruby <<-RUBY
def a.foo
  bar()
end
    RUBY
    assert_valid_expression DefsMatcher.new('a', 'foo', ruby)
  end

  test 'method params' do

  end

end
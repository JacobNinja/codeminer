require File.expand_path('../test_helper', __FILE__)

class VariableTest < ParseTestCase

  test 'local variable reference' do
    ruby <<-RUBY
string = 2
string
    RUBY
    assert_valid_child_expression LocalVariableMatcher.new('string')
  end

  test 'method parameter reference' do
    ruby <<-RUBY
def test(foo)
  foo
end
    RUBY
    assert_valid_child_expression LocalVariableMatcher.new('foo'), 4
  end

  test 'nested variable lookup' do
    ruby <<-RUBY
def test(foo)
  foo.bar
end
    RUBY
    assert_valid_child_expression CallMatcher.new('bar', 'foo.bar', receiver: LocalVariableMatcher.new('foo')), 4
  end

  test 'global variables' do
    ruby '$!'
    assert_valid_child_expression Matcher.new(:global_variable, '!', ruby)
  end

  test 'instance variable' do
    ruby '@foo'
    assert_valid_child_expression Matcher.new(:instance_variable, 'foo', ruby)
  end

  test 'class variable' do
    ruby '@@foo'
    assert_valid_child_expression Matcher.new(:class_variable, 'foo', ruby)
  end

  test 'backref variable' do
    ruby '$1'
    assert_valid_child_expression Matcher.new(:backref_variable, '1', ruby)
  end

end
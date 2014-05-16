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
    debug
    assert_valid_child_expression CallMatcher.new('bar', 'foo.bar', receiver: LocalVariableMatcher.new('foo')), 4
  end

end
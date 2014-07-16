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
    assert_valid_child_expression Matcher.new(:global_variable, '$!', ruby)
  end

  test 'global variable assignment' do
    ruby '$foo = 1'
    assert_valid_child_expression GlobalVariableAssignMatcher.new('$foo', Matcher.new(:int, '1'), '$foo = 1')
  end

  test 'instance variable' do
    ruby '@foo'
    assert_valid_child_expression Matcher.new(:instance_variable, '@foo', ruby)
  end

  test 'instance variable assignment' do
    ruby '@foo = 1'
    assert_valid_child_expression InstanceVariableAssignMatcher.new('@foo', Matcher.new(:int, '1'), '@foo = 1')
  end

  test 'class variable' do
    ruby '@@foo'
    assert_valid_child_expression Matcher.new(:class_variable, '@@foo', ruby)
  end

  test 'class variable assignment' do
    ruby '@@foo = 1'
    assert_valid_child_expression ClassVariableAssignMatcher.new('@@foo', Matcher.new(:int, '1'), '@@foo = 1')
  end

  test 'backref variable' do
    ruby '$1'
    assert_valid_child_expression Matcher.new(:backref_variable, '1', ruby)
  end

  test 'const path ref' do
    ruby 'Foo::Bar'
    assert_valid_child_expression Colon2Matcher.new('Bar', Matcher.new(:constant, 'Foo'), ruby)
  end

  test 'colon2 assign' do
    ruby 'Foo::Bar = 1'
    assert_valid_child_expression Colon2AssignMatcher.new(Colon2Matcher.new('Bar', Matcher.new(:constant, 'Foo'), 'Foo::Bar'), Matcher.new(:int, '1'), ruby)
  end

  # top_const_field
  test 'colon3' do
    ruby '::Foo'
    assert_valid_child_expression Matcher.new(:colon3, 'Foo', ruby)
  end

  test 'colon3 assign' do
    ruby '::Foo = bar'
    assert_valid_child_expression Colon3AssignMatcher.new(Matcher.new(:colon3, 'Foo', '::Foo'), CallMatcher.new('bar'), ruby)
  end

end
require File.expand_path('../test_helper', __FILE__)

class ClassTest < ParseTestCase

  test 'class' do
    ruby <<-RUBY
class Test
end
    RUBY
    assert_valid_child_expression ClassMatcher.new('Test', ruby)
  end

  test 'class with instance method' do
    ruby <<-RUBY
class Test
  def foo
    bar * bar
  end
end
    RUBY
    assert_valid_child_expression DefnMatcher.new('foo', <<-EXPECTED), 4
def foo
    bar * bar
  end
    EXPECTED
  end

  test 'class with class method' do
    ruby <<-RUBY
class Test
  def self.foo
    stuff
  end
end
    RUBY
    assert_valid_child_expression DefsMatcher.new(Matcher.new(:self, nil, 'self'), 'foo', BodystmtMatcher.new(CallMatcher.new('stuff'), 'stuff'), <<-EXPECTED), 4
def self.foo
    stuff
  end
    EXPECTED
  end

  test 'multiple classes' do
    ruby <<-RUBY
class Test
end

class Foo
end
    RUBY
    assert_valid_root_expression RootMatcher.new(ClassMatcher.new('Test', "class Test\nend"), ClassMatcher.new('Foo', "class Foo\nend"), ruby)
  end

  test 'module' do
    ruby <<-RUBY
module Test
  def foo
  end
end
    RUBY
    defn = <<-RUBY
def foo
  end
    RUBY
    assert_valid_child_expression ModuleMatcher.new('Test', ruby, BodystmtMatcher.new(DefnMatcher.new('foo', defn), defn))
  end

  test 'sclass' do
    ruby <<-RUBY
class << foo
  bar
end
    RUBY
    assert_valid_child_expression SClassMatcher.new(CallMatcher.new('foo'), BodystmtMatcher.new(CallMatcher.new('bar'), 'bar'), ruby)
  end

end
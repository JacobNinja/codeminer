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
    assert_valid_child_expression DefnMatcher.new('foo', <<-EXPECTED), 2
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
    assert_valid_child_expression DefsMatcher.new('self', 'foo', <<-EXPECTED), 2
def self.foo
    stuff
  end
    EXPECTED
  end

end
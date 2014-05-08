require File.expand_path('../test_helper', __FILE__)

class MethodTest < ParseTestCase

  test 'single quote string literal' do
    ruby <<-RUBY
'foo'
    RUBY
    assert_valid_child_expression StringMatcher.new('foo', ruby)
  end

end
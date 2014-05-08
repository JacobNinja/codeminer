require File.expand_path('../test_helper', __FILE__)

class MethodTest < ParseTestCase

  test 'regular expression' do
    ruby <<-RUBY
/foo/
    RUBY
    assert_valid_child_expression RegexpMatcher.new('foo', ruby)
  end

end
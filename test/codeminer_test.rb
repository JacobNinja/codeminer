require File.expand_path('../test_helper', __FILE__)

class CodeMinerParseTest < ParseTestCase

  test 'root' do
    ruby <<-RUBY
# comment
    RUBY
    assert_valid_root_expression RootMatcher.new(ruby)
  end

  test 'local variables' do
    ruby <<-RUBY
foo = bar
    RUBY
    assert_valid_child_expression Matcher.new(:lasgn, 'foo', ruby)
  end

  test 'return' do
    ruby 'return foo'
    assert_valid_child_expression ReturnMatcher.new(CallMatcher.new('foo', 'foo'), ruby)
  end

end
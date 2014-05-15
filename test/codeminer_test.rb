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

  test 'integer' do
    ruby '1'
    assert_valid_child_expression Matcher.new(:int, '1', '1')
  end

  test 'unary' do
    ruby '-1'
    assert_valid_child_expression UnaryMatcher.new('-', Matcher.new(:int, '1', '1'), ruby)
  end

end
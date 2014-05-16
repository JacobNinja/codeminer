require File.expand_path('../test_helper', __FILE__)

class MethodTest < ParseTestCase

  test 'single quote string literal' do
    ruby <<-RUBY
'foo'
    RUBY
    assert_valid_child_expression StringMatcher.new('foo', ruby)
  end

  test 'double quoted string' do
    ruby <<-RUBY
"foo"
    RUBY
    assert_valid_child_expression StringMatcher.new('foo', ruby)
  end

  test 'dynamic string' do
    ruby '"foo#{bar}"'
    assert_valid_child_expression DynamicStringMatcher.new(StringMatcher.new('foo', 'foo'), StringEmbeddedMatcher.new(CallMatcher.new('bar', 'bar'), '#{bar}'), ruby)
  end

  test 'really dynamic string' do
    ruby '"#{foo()}bar#{baz}"'
    assert_valid_child_expression DynamicStringMatcher.new(StringEmbeddedMatcher.new(CallMatcher.new('foo', 'foo()'), '#{foo()}'), StringMatcher.new('bar', 'bar'), StringEmbeddedMatcher.new(CallMatcher.new('baz', 'baz'), '#{baz}'), ruby)
  end

  test 'empty string' do
    ruby '""'
    assert_valid_child_expression StringMatcher.new('', ruby)
  end

  test 'heredoc' do
    ruby <<-RUBY
<<-HEREDOC
foo
HEREDOC
    RUBY
    debug
    assert_valid_child_expression StringMatcher.new("foo\n", ruby)
  end

end
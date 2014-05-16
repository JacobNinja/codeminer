require File.expand_path('../test_helper', __FILE__)

class SymbolTest < ParseTestCase

  test 'symbol' do
    ruby ':foo'
    assert_valid_child_expression Matcher.new(:symbol, 'foo', ruby)
  end

  test 'dynamic symbol' do
    ruby ':"foo"'
    debug
    assert_valid_child_expression DynamicSymbolMatcher.new(StringMatcher.new('foo', '"foo"'), ruby)
  end

end
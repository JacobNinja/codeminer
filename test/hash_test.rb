require File.expand_path('../test_helper', __FILE__)

class HashTest < ParseTestCase

  test 'hash labels' do
    ruby '{foo: bar}'
    assert_valid_child_expression HashMatcher.new(HashPairMatcher.new(Matcher.new(:symbol, 'foo', 'foo:'), CallMatcher.new('bar', 'bar'), 'foo: bar'), ruby)
  end

  test 'hash strings' do
    ruby '{"foo" => bar}'
    assert_valid_child_expression HashMatcher.new(HashPairMatcher.new(Matcher.new(:string, 'foo', '"foo"'), CallMatcher.new('bar', 'bar'), '"foo" => bar'), ruby)
  end

  test 'bare hash' do
    ruby 'method(foo: bar)'
    debug
    assert_valid_child_expression HashMatcher.new(HashPairMatcher.new(Matcher.new(:symbol, 'foo', 'foo:'), CallMatcher.new('bar', 'bar'), 'foo: bar'), 'foo: bar'), 4
  end

end
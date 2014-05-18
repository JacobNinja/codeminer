require File.expand_path('./../test_helper', __FILE__)

class AssignmentTest < ParseTestCase

  test 'local assignment' do
    ruby 'foo = bar()'
    assert_valid_child_expression AssignmentMatcher.new('foo', CallMatcher.new('bar', 'bar()'), ruby)
  end

  test 'multiple assignment' do
    ruby 'foo, bar = 5, baz'
    assert_valid_child_expression MultipleAssignmentMatcher.new(ruby, DestructuredParamsMatcher.new(Matcher.new(:ident, 'foo'), Matcher.new(:ident, 'bar'), 'foo, bar'), [Matcher.new(:int, '5'), CallMatcher.new('baz', 'baz')])
  end

  test 'assignment with left splat' do
    ruby 'foo, *bar = baz'
    debug
    assert_valid_child_expression MultipleAssignmentMatcher.new(ruby, DestructuredParamsMatcher.new(Matcher.new(:ident, 'foo'), SplatMatcher.new('bar', '*bar'), 'foo, *bar'), [CallMatcher.new('baz', 'baz')])
  end

  test 'assignment with right splat' do
    ruby 'foo, bar = *baz'
    debug
    assert_valid_child_expression MultipleAssignmentMatcher.new(ruby, DestructuredParamsMatcher.new(Matcher.new(:ident, 'foo'), Matcher.new(:ident, 'bar'), 'foo, bar'), [SplatMatcher.new('baz', '*baz')])
  end

end
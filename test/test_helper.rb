require 'test/unit'

require File.expand_path('./../../lib/codeminer', __FILE__)

# Test Matchers

require File.expand_path('../matchers/matcher', __FILE__)
require File.expand_path('../matchers/defn_matcher', __FILE__)
require File.expand_path('../matchers/defs_matcher', __FILE__)
require File.expand_path('../matchers/class_matcher', __FILE__)

class ParseTestCase < Test::Unit::TestCase

  def assert_valid_expression(matcher)
    expression = find_expression(matcher.type)
    matcher.assert(expression)
  end

  def assert_valid_child_expression(matcher)
    assert_not_empty root.children, 'Expected children not to be empty'
    expression = find_expression(matcher.type, root.children)
    matcher.assert(expression)
  end

  def find_expression(type, expressions=parsed)
    expressions.find {|expression| expression.type == type }.tap do |expression|
      assert_not_nil expression, "Couldn't find parsed expression of type: #{type}"
    end
  end

  def parsed
    CodeMiner.parse(ruby).tap do |parsed|
      assert_not_empty parsed, "Parse was empty...\n#{Ripper.sexp(ruby)}"
    end
  end

  def root
    parsed.first
  end

  def ruby(code=nil)
    @ruby = code if code
    @ruby
  end


end

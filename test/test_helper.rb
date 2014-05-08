require 'test/unit'

require File.expand_path('./../../lib/codeminer', __FILE__)

# Test Matchers

require File.expand_path('../matchers/matcher', __FILE__)
require File.expand_path('../matchers/block_matcher', __FILE__)
require File.expand_path('../matchers/call_matcher', __FILE__)
require File.expand_path('../matchers/call_with_block_matcher', __FILE__)
require File.expand_path('../matchers/class_matcher', __FILE__)
require File.expand_path('../matchers/defn_matcher', __FILE__)
require File.expand_path('../matchers/defs_matcher', __FILE__)
require File.expand_path('../matchers/local_variable_matcher', __FILE__)
require File.expand_path('../matchers/params_matcher', __FILE__)
require File.expand_path('../matchers/root_matcher', __FILE__)
require File.expand_path('../matchers/regexp_matcher', __FILE__)
require File.expand_path('../matchers/string_matcher', __FILE__)

class ParseTestCase < Test::Unit::TestCase

  def assert_valid_root_expression(matcher)
    matcher.assert(root)
  end

  def assert_valid_child_expression(matcher, depth=1)
    nested_exp = depth.pred.times.reduce(root) do |exp, depth|
      assert_not_empty(exp.each)
      exp.each.first
    end
    matched_exp = find_expression(matcher.type, nested_exp)
    matcher.assert(matched_exp)
  end

  def find_expression(type, expression)
    expression.each.find {|exp| exp.type == type }.tap do |exp|
      assert_not_nil exp, "Couldn't find parsed expression of type: #{type}\n#{expression}\n#{Ripper.sexp(ruby)}"
    end
  end

  def root
    CodeMiner.parse(ruby).tap do |parsed|
      assert_not_nil parsed, "Parse was nil...\n#{Ripper.sexp(ruby)}"
    end
  end

  def ruby(code=nil)
    @ruby = code if code
    @ruby
  end


end

require 'test/unit'

require File.expand_path('./../../lib/codeminer', __FILE__)

# Test Matchers

require File.expand_path('../matchers/matcher', __FILE__)
require File.expand_path('../matchers/alias_matcher', __FILE__)
require File.expand_path('../matchers/arguments_matcher', __FILE__)
require File.expand_path('../matchers/aref_assign_matcher', __FILE__)
require File.expand_path('../matchers/aref_field_matcher', __FILE__)
require File.expand_path('../matchers/array_matcher', __FILE__)
require File.expand_path('../matchers/assignment_matcher', __FILE__)
require File.expand_path('../matchers/attribute_assign_matcher', __FILE__)
require File.expand_path('../matchers/begin_matcher', __FILE__)
require File.expand_path('../matchers/binary_matcher', __FILE__)
require File.expand_path('../matchers/block_matcher', __FILE__)
require File.expand_path('../matchers/body_matcher', __FILE__)
require File.expand_path('../matchers/bodystmt_matcher', __FILE__)
require File.expand_path('../matchers/break_matcher', __FILE__)
require File.expand_path('../matchers/call_matcher', __FILE__)
require File.expand_path('../matchers/case_matcher', __FILE__)
require File.expand_path('../matchers/class_matcher', __FILE__)
require File.expand_path('../matchers/class_variable_assign_matcher', __FILE__)
require File.expand_path('../matchers/colon2_assign_matcher', __FILE__)
require File.expand_path('../matchers/colon2_matcher', __FILE__)
require File.expand_path('../matchers/colon3_assign_matcher', __FILE__)
require File.expand_path('../matchers/command_matcher', __FILE__)
require File.expand_path('../matchers/conditional_matcher', __FILE__)
require File.expand_path('../matchers/constant_assign_matcher', __FILE__)
require File.expand_path('../matchers/defn_matcher', __FILE__)
require File.expand_path('../matchers/defs_matcher', __FILE__)
require File.expand_path('../matchers/destructured_params_matcher', __FILE__)
require File.expand_path('../matchers/dynamic_string_matcher', __FILE__)
require File.expand_path('../matchers/dynamic_symbol_matcher', __FILE__)
require File.expand_path('../matchers/else_matcher', __FILE__)
require File.expand_path('../matchers/empty_matcher', __FILE__)
require File.expand_path('../matchers/empty_params_matcher', __FILE__)
require File.expand_path('../matchers/for_matcher', __FILE__)
require File.expand_path('../matchers/global_variable_assign_matcher', __FILE__)
require File.expand_path('../matchers/hash_matcher', __FILE__)
require File.expand_path('../matchers/hash_pair_matcher', __FILE__)
require File.expand_path('../matchers/instance_variable_assign_matcher', __FILE__)
require File.expand_path('../matchers/keyword_params_matcher', __FILE__)
require File.expand_path('../matchers/lambda_matcher', __FILE__)
require File.expand_path('../matchers/local_variable_matcher', __FILE__)
require File.expand_path('../matchers/module_matcher', __FILE__)
require File.expand_path('../matchers/multiple_assignment_matcher', __FILE__)
require File.expand_path('../matchers/next_matcher', __FILE__)
require File.expand_path('../matchers/nil_matcher', __FILE__)
require File.expand_path('../matchers/optional_params_matcher', __FILE__)
require File.expand_path('../matchers/params_matcher', __FILE__)
require File.expand_path('../matchers/positional_params_matcher', __FILE__)
require File.expand_path('../matchers/range_matcher', __FILE__)
require File.expand_path('../matchers/rescue_body_matcher', __FILE__)
require File.expand_path('../matchers/rescue_matcher', __FILE__)
require File.expand_path('../matchers/rescue_match_matcher', __FILE__)
require File.expand_path('../matchers/return_matcher', __FILE__)
require File.expand_path('../matchers/root_matcher', __FILE__)
require File.expand_path('../matchers/regexp_matcher', __FILE__)
require File.expand_path('../matchers/sclass_matcher', __FILE__)
require File.expand_path('../matchers/splat_matcher', __FILE__)
require File.expand_path('../matchers/string_matcher', __FILE__)
require File.expand_path('../matchers/string_embedded_matcher', __FILE__)
require File.expand_path('../matchers/unary_matcher', __FILE__)
require File.expand_path('../matchers/undef_matcher', __FILE__)
require File.expand_path('../matchers/until_matcher', __FILE__)
require File.expand_path('../matchers/when_matcher', __FILE__)
require File.expand_path('../matchers/while_matcher', __FILE__)
require File.expand_path('../matchers/yield_matcher', __FILE__)

class ParseTestCase < Test::Unit::TestCase

  def assert_valid_root_expression(matcher)
    matcher.assert(root)
  end

  def assert_valid_child_expression(matcher, depth=2)
    expressions = depth.pred.times.reduce([root]) do |exps, depth|
      exps.compact.flat_map(&:each).tap do |nested_expressions|
        assert_not_empty(nested_expressions, "Found empty expressions at depth #{depth}")
      end
    end
    matched_exp = find_expression(matcher.type, expressions)
    matcher.assert(matched_exp)
  end

  def find_expression(type, expressions)
    expressions.compact.find {|exp| exp.type == type }.tap do |exp|
      assert_not_nil exp, "Couldn't find parsed expression of type: #{type} in #{expressions}\n#{Ripper.sexp(ruby)}"
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

  def debug
    p Ripper.sexp_raw(@ruby) if @ruby
  end

end

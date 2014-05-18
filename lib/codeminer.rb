require File.expand_path('../codeminer/expressions/expression', __FILE__)
require File.expand_path('../codeminer/expressions/alias_expression', __FILE__)
require File.expand_path('../codeminer/expressions/array_expression', __FILE__)
require File.expand_path('../codeminer/expressions/arguments_expression', __FILE__)
require File.expand_path('../codeminer/expressions/backref_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/body_expression', __FILE__)
require File.expand_path('../codeminer/expressions/binary_expression', __FILE__)
require File.expand_path('../codeminer/expressions/block_expression', __FILE__)
require File.expand_path('../codeminer/expressions/bodystmt_expression', __FILE__)
require File.expand_path('../codeminer/expressions/break_expression', __FILE__)
require File.expand_path('../codeminer/expressions/call_expression', __FILE__)
require File.expand_path('../codeminer/expressions/class_expression', __FILE__)
require File.expand_path('../codeminer/expressions/class_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/condition_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defn_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defs_expression', __FILE__)
require File.expand_path('../codeminer/expressions/destructured_param_expression', __FILE__)
require File.expand_path('../codeminer/expressions/dynamic_symbol_expression', __FILE__)
require File.expand_path('../codeminer/expressions/else_expression', __FILE__)
require File.expand_path('../codeminer/expressions/empty_expression', __FILE__)
require File.expand_path('../codeminer/expressions/global_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/hash_expression', __FILE__)
require File.expand_path('../codeminer/expressions/hash_pair_expression', __FILE__)
require File.expand_path('../codeminer/expressions/instance_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/int_expression', __FILE__)
require File.expand_path('../codeminer/expressions/local_assign_expression', __FILE__)
require File.expand_path('../codeminer/expressions/local_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/multiple_assignment_expression', __FILE__)
require File.expand_path('../codeminer/expressions/next_expression', __FILE__)
require File.expand_path('../codeminer/expressions/optional_param_expression', __FILE__)
require File.expand_path('../codeminer/expressions/params_expression', __FILE__)
require File.expand_path('../codeminer/expressions/params_container', __FILE__)
require File.expand_path('../codeminer/expressions/positional_param_expression', __FILE__)
require File.expand_path('../codeminer/expressions/regexp_expression', __FILE__)
require File.expand_path('../codeminer/expressions/return_expression', __FILE__)
require File.expand_path('../codeminer/expressions/root_expression', __FILE__)
require File.expand_path('../codeminer/expressions/splat_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_content_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_embedded_expression', __FILE__)
require File.expand_path('../codeminer/expressions/symbol_expression', __FILE__)
require File.expand_path('../codeminer/expressions/unknown_expression', __FILE__)
require File.expand_path('../codeminer/expressions/unary_expression', __FILE__)
require File.expand_path('../codeminer/expressions/variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/void_expression', __FILE__)
require File.expand_path('../codeminer/expressions/yield_expression', __FILE__)

require File.expand_path('../codeminer/token', __FILE__)
require File.expand_path('../codeminer/expression_parser_ripper', __FILE__)require File.expand_path('../codeminer/source_extract', __FILE__)

class CodeMiner

  ParseError = Class.new(RuntimeError)

  def self.parse(code)
    expression_parser = ExpressionParserRipper
    expression_parser.parse(code)
  end

end
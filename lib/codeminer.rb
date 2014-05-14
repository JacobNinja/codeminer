require File.expand_path('../codeminer/expressions/expression', __FILE__)
require File.expand_path('../codeminer/expressions/body_expression', __FILE__)
require File.expand_path('../codeminer/expressions/binary_expression', __FILE__)
require File.expand_path('../codeminer/expressions/block_expression', __FILE__)
require File.expand_path('../codeminer/expressions/bodystmt_expression', __FILE__)
require File.expand_path('../codeminer/expressions/call_expression', __FILE__)
require File.expand_path('../codeminer/expressions/class_expression', __FILE__)
require File.expand_path('../codeminer/expressions/condition_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defn_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defs_expression', __FILE__)
require File.expand_path('../codeminer/expressions/else_expression', __FILE__)
require File.expand_path('../codeminer/expressions/local_assign_expression', __FILE__)
require File.expand_path('../codeminer/expressions/local_variable_expression', __FILE__)
require File.expand_path('../codeminer/expressions/optional_param_expression', __FILE__)
require File.expand_path('../codeminer/expressions/params_expression', __FILE__)
require File.expand_path('../codeminer/expressions/params_container', __FILE__)
require File.expand_path('../codeminer/expressions/positional_param_expression', __FILE__)
require File.expand_path('../codeminer/expressions/regexp_expression', __FILE__)
require File.expand_path('../codeminer/expressions/return_expression', __FILE__)
require File.expand_path('../codeminer/expressions/root_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_content_expression', __FILE__)
require File.expand_path('../codeminer/expressions/string_embedded_expression', __FILE__)
require File.expand_path('../codeminer/expressions/unknown_expression', __FILE__)

require File.expand_path('../codeminer/token', __FILE__)
require File.expand_path('../codeminer/expression_parser_ripper', __FILE__)
require File.expand_path('../codeminer/source_extract', __FILE__)

class CodeMiner

  def self.parse(code)
    expression_parser = ExpressionParserRipper
    expression_parser.parse(code)
  end

end
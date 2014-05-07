require File.expand_path('../codeminer/expressions/expression', __FILE__)
require File.expand_path('../codeminer/expressions/block_expression', __FILE__)
require File.expand_path('../codeminer/expressions/bodystmt_expression', __FILE__)
require File.expand_path('../codeminer/expressions/class_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defn_expression', __FILE__)
require File.expand_path('../codeminer/expressions/defs_expression', __FILE__)
require File.expand_path('../codeminer/expressions/root_expression', __FILE__)
require File.expand_path('../codeminer/expressions/call_expression', __FILE__)
require File.expand_path('../codeminer/expressions/params_expression', __FILE__)
require File.expand_path('../codeminer/expressions/local_assign_expression', __FILE__)

require File.expand_path('../codeminer/token', __FILE__)
require File.expand_path('../codeminer/expression_parser_ripper', __FILE__)
require File.expand_path('../codeminer/source_extract', __FILE__)

class CodeMiner

  def self.parse(code)
    expression_parser = ExpressionParserRipper
    expression_parser.parse(code)
  end

end
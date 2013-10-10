require File.expand_path('../codeminer/expression', __FILE__)
require File.expand_path('../codeminer/token', __FILE__)
require File.expand_path('../codeminer/expression_parser_ripper', __FILE__)
require File.expand_path('../codeminer/source_extract', __FILE__)

class CodeMiner

  def self.parse(code)
    expression_parser = ExpressionParserRipper
    expression_parser.parse(code)
  end

end
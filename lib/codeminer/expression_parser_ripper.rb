require 'ripper'
require File.expand_path('../processors/assignment_processor', __FILE__)
require File.expand_path('../processors/call_processor', __FILE__)
require File.expand_path('../processors/class_processor', __FILE__)
require File.expand_path('../processors/default_processor', __FILE__)
require File.expand_path('../processors/method_processor', __FILE__)
require File.expand_path('../processors/regexp_processor', __FILE__)
require File.expand_path('../processors/string_processor', __FILE__)
require File.expand_path('../processors/token_processor', __FILE__)

class ExpressionParserRipper < Ripper

  include AssignmentProcessor, CallProcessor, ClassProcessor, MethodProcessor, RegexpProcessor, TokenProcessor,
          StringProcessor,
          DefaultProcessor

  def initialize(src, *args)
    @src = src
    @keywords = []
    @begin_regex = []
    super
  end

  def on_var_ref(token)
    LocalVariableExpression.new(token)
  end

  def on_void_stmt
    VoidExpression
  end

  def on_paren(body)
    body
  end

  def on_bodystmt(a, b, c, d)
    BodystmtExpression.new(a, b, c, d)
  end

  def on_program(body)
    RootExpression.new(body, @src)
  end

  def on_arg_paren(*args)
    args.compact
  end

  private

  def extract_src_by_token(token, line=lineno(), col=column())
    SourceExtract.extract_by_token(@src, token, line, col)
  end

  def extract_src(begin_line, begin_column, end_line=lineno(), end_column=column())
    SourceExtract.new(@src, begin_line, begin_column, end_line, end_column)
  end

  def extract_params_source(params)
    extract_src(params.first.line, params.last.line, params.first.column, params.last.column)
  end


end
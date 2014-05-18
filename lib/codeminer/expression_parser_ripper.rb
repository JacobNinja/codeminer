require 'ripper'
require File.expand_path('../processors/argument_processor', __FILE__)
require File.expand_path('../processors/array_processor', __FILE__)
require File.expand_path('../processors/assignment_processor', __FILE__)
require File.expand_path('../processors/binary_processor', __FILE__)
require File.expand_path('../processors/call_processor', __FILE__)
require File.expand_path('../processors/class_processor', __FILE__)
require File.expand_path('../processors/condition_processor', __FILE__)
require File.expand_path('../processors/default_processor', __FILE__)
require File.expand_path('../processors/hash_processor', __FILE__)
require File.expand_path('../processors/method_processor', __FILE__)
require File.expand_path('../processors/params_processor', __FILE__)
require File.expand_path('../processors/regexp_processor', __FILE__)
require File.expand_path('../processors/return_processor', __FILE__)
require File.expand_path('../processors/string_processor', __FILE__)
require File.expand_path('../processors/symbol_processor', __FILE__)
require File.expand_path('../processors/token_processor', __FILE__)
require File.expand_path('../processors/variable_processor', __FILE__)

class ExpressionParserRipper < Ripper

  include AssignmentProcessor, CallProcessor, ClassProcessor, MethodProcessor, RegexpProcessor, TokenProcessor,
          StringProcessor, ConditionProcessor, BinaryProcessor, ReturnProcessor, ParamsProcessor, ArgumentProcessor,
          HashProcessor, SymbolProcessor, VariableProcessor, ArrayProcessor,
          DefaultProcessor

  def initialize(src, *args)
    @src = src
    @keywords = []
    @begin_regex = []
    @embexpr = []
    @string_begin = []
    @string_end = []
    @symbol_begin = []
    @string_content = []
    @parens_begin = []
    @qwords = []
    super
  end

  def on_break(args)
    BreakExpression.new(args, extract_src_by_token(pop_keyword))
  end

  def on_alias(left, right)
    AliasExpression.new(left, right, extract_src_by_token(pop_keyword))
  end

  def on_yield(args)
    YieldExpression.new(args, extract_src_by_token(pop_keyword))
  end

  def on_int(*)
    token = super
    IntExpression.new(token, extract_src_by_tokens(token))
  end

  def on_unary(value, receiver)
    UnaryExpression.new(value.to_s.chomp('@'), receiver, extract_src(receiver.line, receiver.column - 1))
  end

  def on_void_stmt
    VoidExpression.new(lineno(), column())
  end

  def on_bodystmt(a, b, c, d)
    BodystmtExpression.new(a, b, c, d)
  end

  def on_stmts_new
    BodyExpression.new
  end

  def on_stmts_add(body, statement)
    assert body.kind_of?(BodyExpression), "Expected body #{body} to be type of BodyExpression"
    body.add(statement)
  end

  def on_program(body)
    RootExpression.new(body, @src)
  end

  def compile_error(msg)
    raise CodeMiner::ParseError, msg
  end

  private

  def extract_src_by_token(token, line=lineno(), col=column())
    SourceExtract.extract_by_token(@src, token, line, col)
  end

  def extract_src_by_tokens(begin_token, end_token=begin_token)
    SourceExtract.extract_by_tokens(@src, begin_token, end_token)
  end

  def extract_src_by_value(value)
    extract_src(lineno(), column(), lineno(), column() + value.length)
  end

  def extract_src(begin_line, begin_column, end_line=lineno(), end_column=column())
    SourceExtract.new(@src, begin_line, begin_column, end_line, end_column)
  end

  def extract_params_source(params)
    extract_src(params.first.line, params.last.line, params.first.column, params.last.column)
  end

  def assert(t, msg)
    raise CodeMiner::ParseError, msg unless t
  end

  def pop_keyword
    @keywords.pop
  end

end
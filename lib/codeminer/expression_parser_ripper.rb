require 'ripper'

class ExpressionParserRipper < Ripper

  def self.tokens(*attrs)
    attrs.each do |attr|
      define_method :"on_#{attr}" do |token|
        token
      end
    end
  end

  SCANNER_EVENTS.each do |event|
    define_method :"on_#{event}" do |token|
      Token.new(event.to_sym, token, lineno(), column())
    end
  end

  PARSER_EVENT_TABLE.each do |event, arity|
    if /_new\z/ =~ event.to_s and arity == 0
      define_method :"on_#{event}" do
        []
      end
    elsif /_add\z/ =~ event.to_s
      define_method :"on_#{event}" do |list, item|
        list.tap {|l| l << item }
      end
    else
      define_method :"on_#{event}" do |*args|
        Expression.new(event.to_s, nil, nil, [], lineno(), column())
      end
    end
  end

  def on_lbrace(token)
    @keywords << Token.new('{', nil, lineno(), column())
    token
  end

  def on_kw(kw)
    Token.new(:kw, kw, lineno(), column()).tap do |token|
      @keywords << token if %w(do class def).include?(kw)
    end
  end

  tokens :var_ref, :const_ref, :var_field

  def initialize(src, *args)
    @src = src
    @keywords = []
    super
  end

  def on_class(token, parent, body)
    ClassExpression.new(token.value, body, extract_src_by_token(@keywords.pop))
  end

  def on_void_stmt
    VoidExpression
  end

  def on_def(token, params, body)
    DefnExpression.new(token.value, params, body, extract_src_by_token(@keywords.pop))
  end

  def on_params(positional, b, c, d, e, f, g)
    src = positional ? extract_params_source(positional) : nil
    ParamsExpression.new(src, positional)
  end

  def on_paren(body)
    body
  end

  def on_defs(receiver, period_token, name_token, params, body)
    DefsExpression.new(receiver, name_token.value, extract_src_by_token(@keywords.pop), body)
  end

  def on_assign(token, body)
    LocalAssignExpression.new(token, body, extract_src_by_token(token, body.line, body.end_column))
  end

  def on_vcall(token)
    CallExpression.new(token, extract_src_by_token(token))
  end

  def on_call(receiver, delimiter, token)
    receiver.delimiter = delimiter
    CallExpression.new(token, extract_src_by_token(receiver), receiver: receiver)
  end

  def on_fcall(token)
    CallExpression.new(token, extract_src_by_token(token))
  end

  def on_bodystmt(a, b, c, d)
    BodystmtExpression.new(a, b, c, d)
  end

  def on_program(body)
    RootExpression.new(body, @src)
  end

  def on_brace_block(args, body)
    BlockExpression.new(body, args, extract_src_by_token(@keywords.pop))
  end

  alias_method :on_do_block, :on_brace_block

  def on_method_add_block(exp, args)
    exp.block = args
    exp
  end

  def on_method_add_arg(exp, args)
    exp.args = args
    exp
  end

  def on_arg_paren(*args)
    args.compact
  end

  private

  def extract_src_by_token(token, line=lineno(), col=column())
    source_extract.extract_by_token(token, line, col)
  end

  def extract_src(begin_line, begin_column, end_line=lineno(), end_column=column())
    source_extract.extract(begin_line, begin_column, end_line, end_column)
  end

  def extract_params_source(params)
    source_extract.extract_by_range(params.first.line, params.first.column..params.last.column)
  end

  def source_extract
    SourceExtract.new(@src)
  end

end
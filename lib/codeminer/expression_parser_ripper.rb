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
        args
      end
    end
  end

  tokens :var_ref, :const_ref, :var_field

  def initialize(src, *args)
    @src = src
    super
  end

  def on_class(token, parents, body)
    ClassExpression.new(token.value, body, extract_src(token))
  end

  def on_void_stmt
    VoidExpression
  end

  def on_def(token, params, body)
    DefnExpression.new(token.value, params, body, extract_src(token))
  end

  def on_params(positional, b, c, d, e, f, g)
    src = positional ? extract_params_source(positional) : nil
    ParamsExpression.new(src, positional)
  end

  def on_paren(body)
    body
  end

  def on_defs(receiver, period_token, name_token, params, body)
    DefsExpression.new(receiver, name_token.value, extract_src(receiver), body)
  end

  def on_assign(token, body)
    Expression.new(:lasgn, token.value, extract_src(token))
  end

  def on_vcall(token)
    CallExpression.new(token, extract_src(token))
  end

  def on_bodystmt(a, b, c, d)
    BodystmtExpression.new(a, b, c, d)
  end

  def on_program(body)
    RootExpression.new(body, @src)
  end

  private

  def extract_src(token)
    source_extract.extract_by_token(token, lineno())
  end

  def extract_params_source(params)
    SourceExtract.new(@src).extract_by_range(params.first.line, params.first.column..params.last.column)
  end

  def source_extract
    SourceExtract.new(@src)
  end

end
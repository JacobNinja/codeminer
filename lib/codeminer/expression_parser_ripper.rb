require 'ripper'

class ExpressionParserRipper < Ripper::SexpBuilder

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

  tokens :var_ref, :const_ref, :var_field

  def initialize(src, *args)
    @src = src
    @buf = []
    super
  end

  def parse
    super
    @buf
  end

  def on_class(token, parents, body)
    @buf.unshift ClassExpression.new(token.value, body, extract_src(token))
  end

  def on_def(token, params, body)
    @buf.unshift DefnExpression.new(token.value, extract_src(token), body)
  end

  def on_defs(receiver_token, period_token, name_token, params, body)
    @buf.unshift DefsExpression.new(receiver_token.value, name_token.value, extract_src(receiver_token), body)
  end

  def on_assign(token, body)
    @buf.unshift Expression.new(:lasgn, token.value, extract_src(token))
  end

  def on_vcall(token)
    @buf.unshift Expression.new(:call, token.value, extract_src(token))
    token
  end

  def on_bodystmt(a, b, c, d)
    BodystmtExpression.new(a, b, c, d)
  end

  private

  def extract_src(token)
    @src.lines.slice(token.line - 1..lineno() - 1).join
  end
end
require File.expand_path('./../dynamic_string_expression', __FILE__)

class StringExpression < Expression

  def initialize(token, src)
    @token = token
    @src = src
  end

  def type
    :string
  end

  def value
    @token.value
  end

  def line
    @token.line
  end

  def column
    @token.column
  end

  def end_column
    column + value.length
  end

  def add(string, src, line, column)
    DynamicStringExpression.new(*[self, *string], src, line, column)
  end

  def add_quotes(src)
    StringExpression.new(@token, src)
  end

  def each
    []
  end

end
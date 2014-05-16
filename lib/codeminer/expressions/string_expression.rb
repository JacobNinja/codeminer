require File.expand_path('./../dynamic_string_expression', __FILE__)

class StringExpression < Expression

  attr_reader :token

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

  def add(string, src)
    DynamicStringExpression.new(*[self, *string], src)
  end

  def add_quotes(src)
    @src = src
    self
    #StringExpression.new(@token, src)
  end

  def each
    [@token]
  end

end
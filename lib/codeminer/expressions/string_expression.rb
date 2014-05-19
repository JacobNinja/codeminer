require File.expand_path('./../dynamic_string_expression', __FILE__)

class StringExpression < Expression

  def self.convert(exp)
    if exp.kind_of?(Token)
      new(exp, exp.src_extract)
    else
      exp
    end
  end

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
  end

  def each
    [@token]
  end

end
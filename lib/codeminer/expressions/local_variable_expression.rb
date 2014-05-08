class LocalVariableExpression < Expression

  def initialize(token)
    @token = token
  end

  def type
    :var_ref
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
    @token.column + value.length
  end

  def each
    []
  end

  alias_method :src, :value

end
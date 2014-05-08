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

  alias_method :src, :value

end
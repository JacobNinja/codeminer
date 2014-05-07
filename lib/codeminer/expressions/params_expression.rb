class ParamsExpression < Expression

  def initialize(src, positional)
    @src = src
    @positional = positional
  end

  def positional
    @positional.map(&:value)
  end

  def type
    :params
  end

end
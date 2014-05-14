class ParamsExpression < Expression

  attr_reader :positional, :optional

  def initialize(positional, optional)
    @positional = positional
    @optional = optional
  end

  def type
    :params
  end

  def each
    [*positional.each, *optional.each]
  end

end
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

  def line
    each.map(&:line).first
  end

  def column
    each.map(&:column).first
  end

  def end_line
    expression_values.map(&:end_line).last
  end

  def end_column
    expression_values.map(&:end_column).last
  end

  private

  def expression_values
    [*positional.each, *optional.each.map(&:value)]
  end

end
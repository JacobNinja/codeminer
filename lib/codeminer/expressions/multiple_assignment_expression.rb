class MultipleAssignmentExpression < Expression

  attr_reader :params, :values, :value

  def initialize(params, values, src)
    @params = params
    @values = values
    @src = src
  end

  def type
    :massign
  end

  def each
    [params, values]
  end

end
class ArgumentsExpression < Expression

  attr_reader :end_line, :end_column, :value, :token

  def initialize(end_line, end_column, token=nil)
    @arguments = []
    @end_line = end_line
    @end_column = end_column
    @token = token
  end

  def add(exp)
    @arguments << exp
    adjust_src(exp.src_extract)
    self
  end

  def type
    :arguments
  end

  def each
    @arguments
  end

end
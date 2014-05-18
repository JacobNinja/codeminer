class ArgumentsExpression < Expression

  attr_reader :value, :token

  def initialize(src=nil, token=nil)
    @arguments = []
    @src = src
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
class ReturnExpression < Expression

  attr_reader :value

  def initialize(args, src)
    @args = args
    @src = src
  end

  def type
    :return
  end

  def each
    Array(@args)
  end

  def body
    @args
  end

end
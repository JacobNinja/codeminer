class ReturnExpression < Expression

  def initialize(args, src)
    @args = args
    @src = src
  end

  def type
    :return
  end

  def each
    @args.each
  end

  def body
    @args
  end

end
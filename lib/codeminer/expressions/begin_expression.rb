class BeginExpression < Expression

  attr_reader :body

  def initialize(bodystmt, src)
    @bodystmt = bodystmt
    @src = src
  end

  def type
    :begin
  end

  def body
    @bodystmt.body
  end

  def rescue
    @bodystmt.rescue
  end

  def each
    body.each
  end

end
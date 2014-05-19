class DynamicStringExpression < Expression

  attr_reader :value

  def initialize(*body, src)
    @src = src
    @body = body
  end

  def type
    :dynamic_string
  end

  def each
    @body
  end

  def add(string, src)
    @body << string
    @src = src
    self
  end

end
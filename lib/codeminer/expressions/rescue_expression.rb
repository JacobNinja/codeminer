class RescueExpression < Expression

  attr_reader :body, :value

  def initialize(constants, token, resbody, d, src)
    @constants = constants
    @token = token
    @resbody = resbody
    @d = d
    @src = src
  end

  def type
    :rescue
  end

  def each
    [@resbody]
  end

end
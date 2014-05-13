class ConditionExpression < Expression

  attr_reader :test, :consequence, :else_statement

  def initialize(test, consequence, else_statement, src)
    @test = test
    @consequence = consequence
    @else_statement = else_statement
    @src = src
  end

  def type
    :condition
  end

end
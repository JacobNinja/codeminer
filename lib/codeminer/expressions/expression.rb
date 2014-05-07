VoidExpression = Object.new

class Expression

  attr_reader :type, :value, :src, :line, :column
  attr_accessor :block, :args

  def initialize(type, value, src, children, line, column)
    @type, @value, @src, @children, @line, @column = type, value, src, children, line, column
  end

  def <<(obj)
    @children << obj
  end

  def each
    @children
  end

end

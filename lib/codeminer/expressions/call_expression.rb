class CallExpression < Expression

  attr_reader :receiver

  def initialize(token, src, receiver: nil)
    @token = token
    @src = src
    @receiver = receiver
  end

  def type
    :call
  end

  def value
    @token.value
  end

  def line
    @token.line
  end

  def column
    @token.column
  end

  def end_column
    @token.column + value.length
  end

  def src
    if delimiter
      @src.chomp(delimiter.to_s)
    else
      @src
    end
  end

  def each
    []
  end

end
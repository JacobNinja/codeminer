class Token

  attr_reader :type, :value

  def initialize(type, value, src)
    @type = type
    @value = value
    @src = src
  end

  def line
    @src.line
  end

  def column
    @src.column
  end

  def end_line
    @src.end_line
  end

  def end_column
    @src.end_column
  end

  def src
    @src.extract
  end

  def each
    []
  end

end
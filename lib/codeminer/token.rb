class Token < Expression

  attr_reader :type, :value

  def initialize(type, value, src)
    @type = type
    @value = value
    @src = src
  end

  def each
    []
  end

end
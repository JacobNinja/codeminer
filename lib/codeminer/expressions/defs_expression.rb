class DefsExpression

  attr_reader :receiver, :value, :src, :body

  def initialize(receiver, name, src, body)
    @receiver = receiver
    @value = name
    @src = src
    @body = body
  end

  def type
    :defs
  end

end
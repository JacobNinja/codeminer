class MagicCommentExpression < Expression

  attr_reader :value, :key

  def initialize(key, value, src)
    @key = key
    @value = value
    @src = src
  end

  def type
    :magic_comment
  end

  def each
    []
  end

end
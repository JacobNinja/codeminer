class ParamsContainer < Expression

  attr_reader :type, :value

  def initialize(body, type, src=nil)
    @body = body
    @type = type
    @src = src
  end

  def each
    @body
  end

  def add(exp)
    @body << exp
    adjust_src(exp.src_extract)
    self
  end

end
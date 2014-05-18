class ParamsContainer < Expression

  attr_reader :type, :value

  def self.wrap(exp, type, src=exp.src_extract)
    if exp.kind_of?(ParamsContainer)
      exp
    else
      new(Array(exp), type, exp.src_extract)
    end
  end

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
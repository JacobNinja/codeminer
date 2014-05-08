class LocalVariableMatcher < Matcher

  def initialize(name)
    @name = name
  end

  def type
    :var_ref
  end

  def assert(exp)
    assert_equal @name, exp.value
    assert_equal @name, exp.src
  end

end
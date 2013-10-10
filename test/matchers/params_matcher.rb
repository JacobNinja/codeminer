class ParamsMatcher < Matcher

  attr_reader :src

  def initialize(parent_type, src, *positional)
    @parent_type = parent_type
    @src = src
    @positional = positional
  end

  def type
    @parent_type
  end

  def assert(defn_exp)
    exp = defn_exp.params
    assert_equal :params, exp.type
    assert_equal @positional, exp.positional
    assert_equal @src, exp.src
  end

end
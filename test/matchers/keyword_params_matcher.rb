class KeywordParamsMatcher < Matcher

  def initialize(src, params_hash)
    @src = src
    @params_hash = params_hash
  end

  def type
    :keyword_params
  end

  def assert(exp)
    assert_equal @params_hash.length, exp.each.length, "Expected expression each #{exp.each} to equal params hash count"
    @params_hash.zip(exp.each).each do |(expected_token_value, value_matcher), e|
      assert_equal expected_token_value.to_s, e.variable
      value_matcher.assert(e.default)
    end
    assert_equal @src, exp.src
  end

end
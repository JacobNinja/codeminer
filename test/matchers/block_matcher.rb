class BlockMatcher < Matcher

  def initialize(src, *body_matchers, params_matcher: nil)
    @src = src
    @body_matchers = body_matchers
    @params_matcher = params_matcher
  end

  def type
    :block
  end

  def assert(exp)
    assert_equal @body_matchers.count, exp.body.each.count
    exp.body.each.zip(@body_matchers).each do |(e, matcher)|
      matcher.assert(e)
    end
    @params_matcher.assert(exp.params) if @params_matcher
    assert_equal @src.chomp, exp.src.chomp
  end

end
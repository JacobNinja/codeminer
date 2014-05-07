class BlockMatcher < Matcher

  def initialize(src, *matchers)
    @src = src
    @matchers = matchers
  end

  def type
    :block
  end

  def assert(exp)
    assert_equal @src.chomp, exp.src.chomp
    exp.each.each do |e|
      @matchers.each {|m| m.type == e.type and m.assert(e) }
    end
  end

end
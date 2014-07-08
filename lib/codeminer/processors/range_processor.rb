module CodeMiner

  module RangeProcessor

    def on_dot2(left, right)
      RangeExpression.new(left, right, true, extract_src_by_tokens(left, right))
    end

    def on_dot3(left, right)
      RangeExpression.new(left, right, false, extract_src_by_tokens(left, right))
    end

  end

end
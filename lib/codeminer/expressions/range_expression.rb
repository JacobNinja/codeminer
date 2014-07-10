module CodeMiner

  class RangeExpression < Expression

    attr_reader :left, :right, :value

    def initialize(left, right, inclusive, src)
      @left = left
      @right = right
      @inclusive = inclusive
      @src = src
    end

    def inclusive?
      @inclusive
    end

    def type
      :range
    end

    def each
      [@left, @right]
    end

  end

end
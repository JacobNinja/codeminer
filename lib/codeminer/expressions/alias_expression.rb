module CodeMiner

  class AliasExpression < Expression

    attr_reader :left, :right, :value

    def initialize(left, right, src)
      @left = left
      @right = right
      @src = src
    end

    def type
      :alias
    end

    def each
      [@left, @right]
    end

  end

end
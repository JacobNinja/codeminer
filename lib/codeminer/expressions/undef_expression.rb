module CodeMiner

  class UndefExpression < Expression

    attr_reader :value

    def initialize(symbols, src)
      @symbols = symbols
      @src = src
    end

    def type
      :undef
    end

    def each
      @symbols
    end

  end

end
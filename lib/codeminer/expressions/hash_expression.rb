module CodeMiner

  class HashExpression < Expression

    attr_reader :pairs, :value

    def initialize(pairs, src)
      @pairs = pairs
      @src = src
    end

    def type
      :hash
    end

    def each
      @pairs.flat_map(&:each)
    end

  end

end
module CodeMiner

  class HashPairExpression < Expression

    attr_reader :key, :value

    def initialize(key, value, src)
      @key = key
      @value = value
      @src = src
    end

    def type
      :hash_pair
    end

    def each
      [key, value]
    end

  end

end
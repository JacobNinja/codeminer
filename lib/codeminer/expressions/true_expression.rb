module CodeMiner

  class TrueExpression < Expression

    attr_reader :value

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :true
    end

    def each
      []
    end

  end

end
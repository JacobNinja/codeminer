module CodeMiner

  class FalseExpression < Expression

    attr_reader :value

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :false
    end

    def each
      []
    end

  end

end
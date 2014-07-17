module CodeMiner

  class SelfExpression < Expression

    attr_reader :value

    def initialize(token, src)
      @token = token
      @src = src
    end

    def type
      :self
    end

    def each
      []
    end

  end

end
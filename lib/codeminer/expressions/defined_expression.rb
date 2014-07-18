module CodeMiner

  class DefinedExpression < Expression

    attr_reader :body, :value

    def initialize(body, src)
      @body = body
      @src = src
    end

    def type
      :defined
    end

    def each
      [@body]
    end

  end

end
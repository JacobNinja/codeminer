module CodeMiner

  class YieldExpression < Expression

    attr_reader :body, :value

    def initialize(body, src)
      @body = body
      @src = src
    end

    def type
      :yield
    end

    def each
      [@body]
    end

  end

end
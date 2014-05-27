module CodeMiner

  class WhileExpression < Expression

    attr_reader :test, :body

    def initialize(test, body, src)
      @test = test
      @body = body
      @src = src
    end

    def type
      :while
    end

    def each
      [@test, @body]
    end

  end

end
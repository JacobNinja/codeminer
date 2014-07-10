module CodeMiner

  class UntilExpression < Expression

    attr_reader :test, :body, :value

    def initialize(test, body, src)
      @test = test
      @body = body
      @src = src
    end

    def type
      :until
    end

    def each
      [@test, @body]
    end

  end

end
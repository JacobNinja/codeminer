module CodeMiner

  class EnsureExpression < Expression

    attr_reader :body, :value

    def initialize(body, src)
      @body = body
      @src = src
    end

    def type
      :ensure
    end

    def each
      [*body.each]
    end

  end

end
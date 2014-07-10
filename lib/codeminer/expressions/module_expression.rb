module CodeMiner

  class ModuleExpression < Expression

    attr_reader :body

    def initialize(token, body, src)
      @token = token
      @body = body
      @src = src
    end

    def type
      :module
    end

    def value
      @token.value
    end

    def each
      [body]
    end

  end

end
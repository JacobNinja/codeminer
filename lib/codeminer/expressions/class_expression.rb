module CodeMiner

  class ClassExpression < Expression

    attr_reader :body, :parent

    def initialize(token, parent, body, src)
      @token = token
      @parent = parent
      @body = body
      @src = src
    end

    def value
      @token.value
    end

    def type
      :class
    end

    def each
      [parent, body]
    end

  end

end
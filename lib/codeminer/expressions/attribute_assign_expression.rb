module CodeMiner

  class AttributeAssignExpression < Expression

    attr_reader :body

    def initialize(field, body, src)
      @field = field
      @token = token
      @body = body
      @src = src
    end

    def type
      :attribute_assign
    end

    def token
      @field.token
    end

    def value
      token.value
    end

    def each
      [receiver, @body]
    end

    def receiver
      @field.receiver
    end

  end

end
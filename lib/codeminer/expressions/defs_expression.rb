module CodeMiner

  class DefsExpression < Expression

    attr_reader :body, :receiver, :params

    def initialize(receiver, token, params, body, src)
      @receiver = receiver
      @token = token
      @params = params
      @body = body
      @src = src
    end

    def value
      @token.value
    end

    def type
      :defs
    end

    def each
      [receiver, params, *body.each]
    end

  end

end
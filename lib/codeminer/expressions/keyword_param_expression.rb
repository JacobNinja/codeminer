module CodeMiner

  class KeywordParamExpression < Expression

    attr_reader :token, :value

    def initialize(token, value, src)
      @token = token
      @value = value
      @src = src
    end

    def type
      :keyword_param
    end

    def variable
      @token.value
    end

    def default
      @value
    end

    def each
      [@token, @value]
    end

  end

end
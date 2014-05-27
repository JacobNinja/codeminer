module CodeMiner

  class AmbiguousOperatorExpression < Expression

    def initialize(token, msg, src)
      @token = token
      @msg = msg
      @src = src
    end

    def type
      :ambiguous_operator
    end

    def value
      @token.value
    end

    def each
      [msg]
    end

  end

end
module CodeMiner

  class AmbiguousOperatorExpression < Expression

    attr_reader :msg

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
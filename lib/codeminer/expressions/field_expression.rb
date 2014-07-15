module CodeMiner

  class FieldExpression < Expression

    attr_reader :body, :receiver

    def initialize(receiver, token, src)
      @receiver = receiver
      @token = token
      @src = src
    end

    def type
      :field
    end

    def value
      @token.value
    end

    def each
      [@receiver]
    end

  end

end
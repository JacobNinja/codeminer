module CodeMiner

  class ArefFieldExpression < Expression

    attr_reader :receiver, :args

    def initialize(token, receiver, args, src)
      @token = token
      @receiver = receiver
      @args = args
      @src = src
    end

    def value
      @token.value
    end

    def type
      :aref_field
    end

    def each
      [receiver, args]
    end

  end

end
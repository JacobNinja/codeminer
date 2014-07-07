module CodeMiner

  class CommandExpression < Expression

    attr_reader :args, :receiver

    def initialize(token, args, src, receiver=nil)
      @token = token
      @args = args
      @src = src
      @receiver = receiver
    end

    def value
      @token.value
    end

    def type
      :command
    end

    def each
      [@receiver, @args].compact
    end

    alias body args

  end

end
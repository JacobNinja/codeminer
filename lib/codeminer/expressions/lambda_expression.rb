module CodeMiner

  class LambdaExpression < Expression

    attr_reader :args, :body, :value

    def initialize(args, body, src)
      @args = args
      @body = body
      @src = src
    end

    def type
      :lambda
    end

    def each
      [@args, @body]
    end

  end

end
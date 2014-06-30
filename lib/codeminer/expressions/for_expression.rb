module CodeMiner

  class ForExpression < Expression

    attr_reader :params, :receiver, :body, :value

    def initialize(params, receiver, body, src)
      @params = params
      @receiver = receiver
      @body = body
      @src = src
    end

    def each
      [@params, @receiver, @body]
    end

    def type
      :for
    end

  end

end
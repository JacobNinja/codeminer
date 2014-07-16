module CodeMiner

  class Colon2AssignExpression < Expression

    attr_reader :body, :receiver, :value

    def initialize(receiver, body, src)
      @receiver = receiver
      @body = body
      @src = src
    end

    def type
      :colon2_assign
    end

    def each
      [receiver, body]
    end

  end

end
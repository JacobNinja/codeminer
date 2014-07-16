module CodeMiner

  class Colon3AssignExpression < Expression

    attr_reader :body, :receiver, :value

    def initialize(receiver, body, src)
      @receiver = receiver
      @body = body
      @src = src
    end

    def type
      :colon3_assign
    end

    def each
      [receiver, body]
    end

  end

end
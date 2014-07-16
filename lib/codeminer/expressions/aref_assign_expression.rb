module CodeMiner

  class ArefAssignExpression < Expression

    attr_reader :body, :receiver, :value

    def initialize(receiver, body, src)
      @receiver = receiver
      @body = body
      @src = src
    end

    def type
      :aref_assign
    end

    def each
      [receiver, body]
    end

  end

end
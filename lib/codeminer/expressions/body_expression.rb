module CodeMiner

  class BodyExpression < Expression

    attr_reader :value

    def initialize(*body, src)
      @body = body
      @src = src
    end

    def add(statement)
      adjust_src(statement.src_extract)
      @body << statement
      self
    end

    def each
      @body
    end

    def type
      :body
    end

  end

end
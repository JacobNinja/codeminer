module CodeMiner

  class BodyExpression < Expression

    attr_reader :value

    def initialize(src)
      @src_fallback = src
      @body = []
    end

    def add(statement)
      unless statement.kind_of?(VoidExpression)
        adjust_src(statement.src_extract)
        @body << statement
      end
      self
    end

    def each
      @body.each.reject{|e| e.kind_of?(VoidExpression)}
    end

    def type
      :body
    end

  end

end
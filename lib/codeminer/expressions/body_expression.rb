module CodeMiner

  class BodyExpression < Expression

    def self.from(expression)
      new(expression.src_extract, [expression])
    end

    attr_reader :value, :body

    def initialize(src, body=[])
      @src_fallback = src
      @body = body
    end

    def add(statement)
      unless statement.kind_of?(VoidExpression)
        adjust_src(statement.src_extract)
        @body << statement
      end
      self
    end

    def each
      @body.each.to_a
    end

    def type
      :body
    end

  end

end
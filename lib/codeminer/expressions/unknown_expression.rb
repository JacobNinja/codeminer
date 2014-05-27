module CodeMiner

  class UnknownExpression < Expression

    attr_reader :type, :value, :line, :column

    def initialize(type, value, src, children, line, column)
      @type, @value, @src, @children, @line, @column = type, value, src, children, line, column
    end

    def <<(obj)
      @children << obj
    end

    def each
      @children
    end

    def add(obj, src)
      @children << obj
      @src = src
      self
    end

    def end_line
      line
    end

    def end_column
      column + value.to_s.length
    end

  end

end
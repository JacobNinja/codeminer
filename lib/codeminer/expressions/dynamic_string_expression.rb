module CodeMiner

  class DynamicStringExpression < Expression

    def self.wrap(exp)
      if exp.type == :dynamic_string
        exp
      else
        new(exp, exp.src_extract)
      end
    end

    attr_reader :value

    def initialize(*body, src)
      @src = src
      @body = body
    end

    def type
      :dynamic_string
    end

    def each
      @body
    end

    def add(string, src=string.src_extract)
      @body << string
      adjust_src(src)
      self
    end

  end

end
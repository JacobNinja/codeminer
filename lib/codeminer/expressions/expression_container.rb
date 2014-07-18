module CodeMiner

  class ExpressionContainer < Expression

    attr_reader :type, :value

    def self.wrap(exp, type)
      if exp.kind_of?(ExpressionContainer)
        new(exp.each, type, exp.src_extract)
      else
        wrapped = exp.class == Array ? exp : [exp]
        new(wrapped, type, exp.src_extract)
      end
    end

    def initialize(body, type, src=nil)
      @body = body
      @type = type
      @src = src
    end

    def each
      @body
    end

    def add(exp)
      if exp.kind_of?(ExpressionContainer)
        exp.each.each do |e|
          @body << e
          adjust_src(e.src_extract)
        end
      else
        @body << exp
        adjust_src(exp.src_extract)
      end
      self
    end

  end

end
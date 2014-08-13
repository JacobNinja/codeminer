module CodeMiner

  class CallExpression < Expression

    attr_reader :receiver, :args

    def initialize(token, src, receiver: nil, arguments: nil)
      @token = token
      @src = src
      @receiver = receiver
      @args = arguments
    end

    def type
      :call
    end

    def value
      value = @token.value.lstrip
      if value[0] == '.'
        value[1..-1]
      else
        value
      end
    end

    def each
      [@receiver, *[@args, @block].compact]
    end

    alias body args

  end

end
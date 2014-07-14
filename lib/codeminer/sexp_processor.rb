module CodeMiner

  class Sexp

    include SourceExtract::Usage

    attr_reader :exp, :file

    def initialize(expressions, exp)
      @expressions = expressions
      @exp = exp
    end

    def method_missing(meth, *args)
      if @exp.respond_to?(meth)
        @exp.send(meth, *args)
      else
        super
      end
    end

    def src_extract
      @exp.src_extract
    end

    def each
      @exp.each
    end

    def length
      @expressions.length
    end

    def to_a
      @expressions
    end

    def inspect
      "s(#{to_a.map(&:inspect).join(', ')})"
    end

    def ==(other)
      @expressions == other
    end

  end

  class SexpFormatter

    attr_reader :exp

    def initialize(exp, parser)
      @exp = exp
      @parser = parser
    end

    def type
      exp.type
    end

    def value
      exp.value
    end

    def each
      exp.each
    end

    def to_sexp
      if exp.respond_to?(:each)
        format(type, *value, each)
      else
        exp
      end
    end

    def format(*nodes, children)
      CodeMiner::Sexp.new([*nodes, *children.map{|e| @parser.to_sexp(e)}], exp)
    end

    def exp
      @exp.kind_of?(Sexp) ? @exp.exp : @exp
    end

  end

  module SexpProcessor

    BLACKLIST = %w(string_embexpr else void_stmt)
    TOKENS = %w(int)

    Ripper::PARSER_EVENT_TABLE.each do |event, arity|
      next if /_new\z/ =~ event.to_s and arity == 0
      next if /_add\z/ =~ event.to_s
      next if /_content\z/ =~ event.to_s
      next if /_from_[a-z]+\z/ =~ event.to_s
      next if BLACKLIST.include?(event.to_s)

      if /_add_[a-z]+\z/ =~ event.to_s
        define_method :"on_#{event}" do |*args|
          to_sexp_replace(super(*args))
        end
      else
        define_method :"on_#{event}" do |*args|
          to_sexp(super(*args))
        end
      end
    end

    TOKENS.each do |token|
      define_method :"on_#{token}" do |exp|
        to_sexp(super(exp))
      end
    end

    def to_sexp_replace(exp)
      if exp.respond_to?(:type) || exp.kind_of?(Sexp)
        formatter = formatters.fetch(exp.type, SexpFormatter)
        formatter.new(exp, self).to_sexp
      else
        exp
      end
    end

    def to_sexp(exp)
      if exp.respond_to?(:type)
        formatter = formatters.fetch(exp.type, SexpFormatter)
        formatter.new(exp, self).to_sexp
      else
        exp
      end
    end

  end

end
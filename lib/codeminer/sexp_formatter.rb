module CodeMiner

  class Sexp < Array

    include SourceExtract::Usage

    def initialize(expressions, exp)
      super(expressions)
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

    def to_a
      [self]
    end

  end

  module SexpFormatter

    BLACKLIST = %w(string_embexpr)

    Ripper::PARSER_EVENT_TABLE.each do |event, arity|
      next if /_new\z/ =~ event.to_s and arity == 0
      next if /_add\z/ =~ event.to_s
      next if /_content\z/ =~ event.to_s
      next if /_from_[a-z]+\z/ =~ event.to_s
      next if BLACKLIST.include?(event.to_s)

      define_method :"on_#{event}" do |*args|
        to_sexp(super(*args))
      end
    end

    def to_sexp(exp)
      if exp.kind_of?(Sexp) || !exp.respond_to?(:each)
        exp
      else
        CodeMiner::Sexp.new([exp.type, *exp.value, *exp.each.map{|e| to_sexp(e)}], exp)
      end
    end

  end

end
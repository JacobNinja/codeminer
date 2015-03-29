module CodeMiner

  module ExpressionProcessor

    Ripper::PARSER_EVENT_TABLE.each do |event, arity|
      next if event == :parse_error
      next if /_new\z/ =~ event.to_s and arity == 0
      next if /_from_[a-z]+\z/ =~ event.to_s

      define_method :"on_#{event}" do |*args|
        super(*args).tap do |node|
          invoke_processor(node, event)
        end
      end
    end

    private

    def invoke_processor(node, event)
      @processors.each do |p|
        meth = :"process_#{event}"
        p.public_send(meth, node) if p.respond_to?(meth)
        p.process_default(node) if p.respond_to?(:process_default)
      end
    end

  end

end

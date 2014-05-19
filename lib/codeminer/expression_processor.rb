module ExpressionProcessor

  Ripper::PARSER_EVENT_TABLE.each do |event, arity|
    next if event == :parse_error
    next if /_new\z/ =~ event.to_s and arity == 0
    next if /_add\z/ =~ event.to_s
    next if /_from_[a-z]+\z/ =~ event.to_s

    define_method :"on_#{event}" do |*args|
      super(*args).tap do |node|
        invoke_processor(node)
      end
    end
  end

  private

  def invoke_processor(node)
    @processors.each do |p|
      meth = :"process_#{node.type}"
      p.public_send(meth, node) if p.respond_to?(meth)
    end
  end

end
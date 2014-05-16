require 'ripper'

module DefaultProcessor

  Ripper::SCANNER_EVENTS.each do |event|
    define_method :"on_#{event}" do |value|
      Token.new(event.to_sym, value, extract_src_by_value(value))
    end
  end

  Ripper::PARSER_EVENT_TABLE.each do |event, arity|
    if /_new\z/ =~ event.to_s and arity == 0
      define_method :"on_#{event}" do
        []
      end
    elsif /_add\z/ =~ event.to_s
      define_method :"on_#{event}" do |list, item|
        list.tap {|l| l << item }
      end
    else
      define_method :"on_#{event}" do |*args|
        UnknownExpression.new(event.to_s, nil, nil, [], lineno(), column())
      end
    end
  end

end
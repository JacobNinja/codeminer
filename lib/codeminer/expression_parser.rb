require 'ruby_parser'
require 'sexp_processor'

class ExpressionParser < SexpProcessor

  attr_reader :expressions

  def initialize
    super
    self.auto_shift_type = true
    @expressions = []
  end

  def parse(code)
    ast = RubyParser.new.parse(code)
    process(ast)
    @expressions
  end

  def process_class(exp)
    name = exp.shift
    parent = exp.shift
    body = exp.shift
    @expressions << Expression.new(:class, name.to_s, nil)
    s()
  end

end
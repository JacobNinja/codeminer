require File.expand_path('../test_helper', __FILE__)

class SubstitutionTest < Test::Unit::TestCase

  attr_reader :method_node, :code, :last_positional_param_node, :positional_substitute, :sut

  def setup
    @code = <<-RUBY
def foo(a, b)
  b
end
    RUBY
    @method_node = CodeMiner.parse(code).each.first
    @last_positional_param_node = method_node.params.positional.each.last
    @positional_substitute = CodeMiner::Substitution::Value.new(last_positional_param_node, 'bar')
    @sut = CodeMiner::Substitution.new(method_node)
  end

  test 'substitute node' do
    assert_equal <<-RUBY.chomp, sut.substitute(positional_substitute)
def foo(a, bar)
  b
end
    RUBY
  end

  test 'multiple substitutions' do
    local_variable_substitute = CodeMiner::Substitution::Value.new(method_node.body.each.first, 'bar')
    assert_equal <<-RUBY.chomp, sut.substitute(positional_substitute, local_variable_substitute)
def foo(a, bar)
  bar
end
    RUBY
  end

end
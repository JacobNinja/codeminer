require File.expand_path('../test_helper', __FILE__)

class TestProcessor

  attr_reader :class_name

  def process_class(exp)
    @class_name = exp.value
  end

end

class ExpressionProcessorTest < Test::Unit::TestCase

  test 'invokes processor on event' do
    processor = TestProcessor.new
    CodeMiner.process(<<-RUBY, [processor])
class Foo
end
    RUBY
    assert_equal 'Foo', processor.class_name
  end

end

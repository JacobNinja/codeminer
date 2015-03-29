require File.expand_path('../test_helper', __FILE__)

class TestProcessor

  attr_reader :class_name, :default

  def process_class(exp)
    @class_name = exp.value
  end

  def process_default(exp)
    @default ||= exp.value
  end

end

class ExpressionProcessorTest < Test::Unit::TestCase

  attr_reader :processor
  def setup
    @processor = TestProcessor.new
  end

  test 'invokes processor on event' do
    CodeMiner.process(<<-RUBY, [processor])
class Foo
end
    RUBY
    assert_equal 'Foo', processor.class_name
  end

  test 'invokes default process when available' do
    CodeMiner.process(<<-RUBY, [processor])
def bar
end
    RUBY
    assert_equal 'bar', processor.default
  end

end

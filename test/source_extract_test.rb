require File.expand_path('../test_helper', __FILE__)

class SourceExtractTest < Test::Unit::TestCase

  attr_reader :ruby

  def setup
    @ruby = <<-RUBY
class Foo

  def bar(a, b, c)

  end
end
    RUBY
  end

  test 'extracts code given a token' do
    token = Token.new(:class, 'Foo', 1, 0)
    result = SourceExtract.extract_by_token(ruby, token, 6, 3).extract
    assert_equal <<-EXPECTED.chomp, result
class Foo

  def bar(a, b, c)

  end
end
    EXPECTED
  end

end
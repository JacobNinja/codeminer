require File.expand_path('../test_helper', __FILE__)

class SourceExtractTest < Test::Unit::TestCase

  attr_reader :sut

  def setup
    @sut = SourceExtract.new(<<-RUBY)
class Foo

  def bar(a, b, c)

  end
end
    RUBY
  end

  test 'extracts code given a token' do
    token = Token.new(:class, 'Foo', 1, 0)
    result = sut.extract_by_token(token, 6, 3)
    assert_equal <<-EXPECTED.chomp, result
class Foo

  def bar(a, b, c)

  end
end
    EXPECTED
  end

  test 'extracts code given a line and range' do
    assert_equal 'a, b, c', sut.extract_by_range(3, 10..16)
  end

end
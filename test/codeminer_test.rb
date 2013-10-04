require File.expand_path('../test_helper', __FILE__)

class CodeMinerParseTest < ParseTestCase

  test 'local variables' do
    ruby <<-RUBY
foo = bar
    RUBY
    assert_valid_expression Matcher.new(:lasgn, 'foo', ruby)
  end

end
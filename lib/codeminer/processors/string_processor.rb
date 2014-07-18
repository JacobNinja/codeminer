module CodeMiner

  module StringProcessor

    def on_tstring_content(value)
      Token.new(:string, value, extract_src_by_value(value))
    end

    def on_string_add(string_content, string)
      string_content.add(string, extract_src_by_tokens(string))
    end

    def on_string_content
      StringContentExpression.new
    end

    def on_string_concat(str1, str2)
      dynamic_string = DynamicStringExpression.wrap(str1)
      dynamic_string.add(str2)
    end

    def on_string_embexpr(body)
      body.each.last.delimiter = '}'
      embedded_expression_src = extract_src_by_token(@embexpr.pop)
      StringEmbeddedExpression.new(body, embedded_expression_src)
    end

    def on_string_literal(string_content)
      string_content.src = extract_src_by_tokens(@string_begin.pop, @string_end.pop)
      string_content
    end

    def on_xstring_new
      StringContentExpression.new
    end

    def on_xstring_add(body, string)
      body.add(string, extract_src_by_tokens(string))
    end

    def on_tstring_beg(*)
      super.tap do |token|
        @string_begin << token
      end
    end

    def on_tstring_end(*)
      super.tap do |token|
        @string_end << token
      end
    end

    def on_embexpr_beg(*)
      super.tap do |token|
        @embexpr << token
      end
    end

    def on_heredoc_beg(*)
      super.tap do |token|
        @string_begin << token
      end
    end

    def on_heredoc_end(*)
      super.tap do |token|
        @string_end << token
      end
    end

  end

end
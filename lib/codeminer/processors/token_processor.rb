module CodeMiner

  module TokenProcessor

    def self.tokens(*attrs)
      attrs.each do |attr|
        define_method :"on_#{attr}" do |token|
          token
        end
      end
    end

    tokens :const_ref

    def on_lbrace(token)
      @lbrace << super
      token
    end

    def on_kw(kw)
      super.tap do |token|
        if %w(do class def if else unless return alias yield break next super begin rescue case when redo retry undef elsif
              until while for module defined? ensure).include?(kw.gsub(/[^a-z?]/, ''))
          @keywords.unshift(token)
        end
      end
    end

    def on_lbracket(value)
      @lbracket = super
    end

    def on_lparen(*)
      super.tap do |token|
        @parens_begin << token
      end
    end

  end

end
module CodeMiner

  class SourceExtract

    attr_accessor :line, :column
    attr_accessor :end_line, :end_column

    class Partial

      attr_reader :end_line, :end_column, :line, :column

      def initialize(src, end_line, end_column)
        @src = src
        @end_line = end_line
        @end_column = end_column
        @line = end_line
        @column = end_column
      end

      def adjust(other)
        SourceExtract.new(@src, other.line, other.column, end_line, end_column)
      end

      def extract
        ''
      end

    end

    module Usage

      def line
        src_extract.line
      end

      def column
        src_extract.column
      end

      def end_line
        src_extract.end_line
      end

      def end_column
        src_extract.end_column
      end

      def line=(line)
        src_extract.line = line
      end

      def column=(column)
        src_extract.column = column
      end

      def end_line=(line)
        src_extract.end_line = line
      end

      def end_column=(column)
        src_extract.end_column = column
      end

      def src
        extracted_source = src_extract.extract
        if delimiter
          extracted_source.chomp(delimiter.to_s)
        else
          extracted_source
        end
      end

      def adjust_src(other)
        if @src
          @src = @src.adjust(other)
        else
          @src = other
        end
      end

      def src_extract
        @src || @src_fallback
      end

    end

    def self.extract_by_token(src, token, end_line, end_column)
      new(src, token.line, token.column, end_line, end_column)
    end

    def self.extract_by_tokens(src, token, end_token)
      new(src, token.line, token.column, end_token.end_line, end_token.end_column)
    end

    def initialize(src, line, column, end_line=nil, end_column=nil)
      @src = src
      @line = line
      @column = column
      @end_line = end_line
      @end_column = end_column
    end

    def extract
      lines = extract_lines(line-1..end_line-1).join
      lines.slice(column, lines.length - (lines.lines.last.length - end_column) - column).to_s.chomp
    end

    def adjust(other)
      self.class.new(@src, line, column, other.end_line, other.end_column)
    end

    private

    def extract_lines(range)
      @src.lines.slice(range)
    end

  end

end
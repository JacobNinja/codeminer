module CodeMiner

  class Substitution

    Value = Struct.new(:node, :replacement, :column_adjustment) do

      def <=>(other)
        if node.line == other.node.line
          node.column <=> other.node.column
        else
          node.line <=> other.node.line
        end
      end

    end

    def initialize(node)
      @node = node
    end

    def substitute(*substitutions)
      @node.src.tap do |src|
        substitutions.sort.inject(0) do |offset, substitution|
          src[substitution_range(substitution, offset - substitution.column_adjustment.to_i)] = substitution.replacement
          offset + (substitution.replacement.length - substitution.node.src.length)
        end
      end
    end

    private

    def substitution_range(substitution, offset)
      begin_column = column_offset(substitution.node.line, substitution.node.column, offset)
      end_column = column_offset(substitution.node.end_line, substitution.node.end_column, offset)
      begin_column...end_column
    end

    def column_offset(line, column, offset)
      [*line_offsets(line), column, offset].reduce(:+)
    end

    def line_offsets(line)
      @node.src.lines.map(&:length).take(line - @node.line)
    end

  end

end
class SourceExtract

  def initialize(src)
    @src = src
  end

  def extract_by_range(line, range)
    extract_lines(line - 1..line - 1).join.each_char.to_a.slice(range).join
  end

  def extract_by_token(token, end_line, end_column)
    extract(token.line, token.column, end_line, end_column)
  end

  def extract(begin_line, begin_column, end_line, end_column)
    lines = extract_lines(begin_line-1..end_line-1).join
    lines.slice(begin_column, lines.length - (lines.lines.last.length - end_column) - begin_column).to_s.chomp
  end

  private

  def extract_lines(range)
    @src.lines.slice(range)
  end

end
class SourceExtract

  def initialize(src)
    @src = src
  end

  def extract_by_range(line, range)
    extract(line - 1..line - 1).join.each_char.to_a.slice(range).join
  end

  def extract(range)
    @src.lines.slice(range)
  end

  def extract_by_token(token, end_line, end_column)
    lines = extract(token.line-1..end_line-1).join
    lines.slice(token.column, lines.length - (lines.lines.last.length - end_column) - token.column).to_s.chomp
  end

end
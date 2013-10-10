class SourceExtract

  def initialize(src)
    @src = src
  end

  def extract_by_token(token, endline)
    slice_lines(token.line - 1..endline - 1).join
  end

  def extract_by_range(line, range)
    slice_lines(line - 1..line - 1).join.each_char.to_a.slice(range).join
  end

  private

  def slice_lines(range)
    @src.lines.slice(range)
  end

end
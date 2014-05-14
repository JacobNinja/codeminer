Token = Struct.new(:type, :value, :line, :column) do

  def end_line
    line
  end

  def end_column
    column + value.length
  end

end
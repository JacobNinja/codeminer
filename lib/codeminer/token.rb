Token = Struct.new(:type, :value, :line, :column, :src) do

  def end_line
    line
  end

  def end_column
    column + value.length
  end

  def src
    self[:src] || value
  end

end
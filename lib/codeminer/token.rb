Token = Struct.new(:type, :value, :line, :column) do

  def end_column
    column + value.length
  end

end
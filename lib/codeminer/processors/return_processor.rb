module ReturnProcessor

  def on_return(body)
    ReturnExpression.new(body, extract_src_by_token(pop_keyword))
  end

end
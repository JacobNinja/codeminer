require File.expand_path('../expressions/class_expression', __FILE__)
require File.expand_path('../expressions/bodystmt_expression', __FILE__)
require File.expand_path('../expressions/defn_expression', __FILE__)
require File.expand_path('../expressions/defs_expression', __FILE__)
require File.expand_path('../expressions/root_expression', __FILE__)
require File.expand_path('../expressions/call_expression', __FILE__)
require File.expand_path('../expressions/params_expression', __FILE__)

Expression = Struct.new(:type, :value, :src, :children)
VoidExpression = Object.new
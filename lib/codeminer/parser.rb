require 'ripper'
require File.expand_path('../processors/argument_processor', __FILE__)
require File.expand_path('../processors/array_processor', __FILE__)
require File.expand_path('../processors/assignment_processor', __FILE__)
require File.expand_path('../processors/binary_processor', __FILE__)
require File.expand_path('../processors/call_processor', __FILE__)
require File.expand_path('../processors/command_processor', __FILE__)
require File.expand_path('../processors/class_processor', __FILE__)
require File.expand_path('../processors/condition_processor', __FILE__)
require File.expand_path('../processors/default_processor', __FILE__)
require File.expand_path('../processors/hash_processor', __FILE__)
require File.expand_path('../processors/loop_processor', __FILE__)
require File.expand_path('../processors/method_processor', __FILE__)
require File.expand_path('../processors/params_processor', __FILE__)
require File.expand_path('../processors/range_processor', __FILE__)
require File.expand_path('../processors/regexp_processor', __FILE__)
require File.expand_path('../processors/return_processor', __FILE__)
require File.expand_path('../processors/string_processor', __FILE__)
require File.expand_path('../processors/symbol_processor', __FILE__)
require File.expand_path('../processors/token_processor', __FILE__)
require File.expand_path('../processors/variable_processor', __FILE__)

require File.expand_path('../expression_processor', __FILE__)
require File.expand_path('../sexp_processor', __FILE__)


module CodeMiner

  class Parser < Ripper

    include AssignmentProcessor, CallProcessor, ClassProcessor, MethodProcessor, RegexpProcessor, TokenProcessor,
            StringProcessor, ConditionProcessor, BinaryProcessor, ReturnProcessor, ParamsProcessor, ArgumentProcessor,
            HashProcessor, SymbolProcessor, VariableProcessor, ArrayProcessor, CommandProcessor, LoopProcessor,
            RangeProcessor,
            DefaultProcessor

    attr_accessor :processors, :formatters

    def initialize(src, *args)
      @src = src
      @keywords = []
      @begin_regex = []
      @embexpr = []
      @string_begin = []
      @string_end = []
      @symbol_begin = []
      @string_content = []
      @parens_begin = []
      @qwords = []
      @qsymbols = []
      @lambda = []
      @symbols = []
      @words = []
      @processors = []
      @lbrace = []
      @formatters = {}
      super
    end

    def self.process(rb, processors)
      parser = new(rb).extend(ExpressionProcessor)
      parser.processors = processors
      parser.parse
      processors
    end

    def self.sexp(rb, formatters={})
      parser = new(rb).extend(SexpProcessor)
      parser.formatters = formatters
      parser.parse
    end

    def on_break(args)
      BreakExpression.new(args, extract_src_by_token(pop_keyword('break')))
    end

    def on_next(args)
      NextExpression.new(args, extract_src_by_token(pop_keyword('next')))
    end

    def on_redo
      RedoExpression.new(extract_src_by_token(pop_keyword('redo')))
    end

    def on_retry
      RetryExpression.new(extract_src_by_token(pop_keyword('retry')))
    end

    def on_zsuper
      token = pop_keyword('super')
      SuperExpression.new(nil, extract_src_by_token(token))
    end

    def on_super(body)
      token = pop_keyword('super')
      SuperExpression.new(body, extract_src_by_tokens(*[token, body].compact))
    end

    def on_alias(left, right)
      AliasExpression.new(left, right, extract_src_by_token(pop_keyword('alias')))
    end

    def on_yield(args)
      YieldExpression.new(args, extract_src_by_token(pop_keyword('yield')))
    end

    def on_yield0
      YieldExpression.new(nil, extract_src_by_token(pop_keyword('yield')))
    end

    def on_undef(symbols)
      UndefExpression.new(symbols, extract_src_by_token(pop_keyword('undef')))
    end

    def on_int(*)
      token = super
      IntExpression.new(token, extract_src_by_tokens(token))
    end

    def on_unary(value, receiver)
      UnaryExpression.new(value.to_s.chomp('@'), receiver, extract_src(receiver.line, receiver.column - 1))
    end

    def on_void_stmt
      VoidExpression.new(extract_src(lineno(), column()))
    end

    def on_begin(body)
      BeginExpression.new(body, extract_src_by_token(pop_keyword('begin')))
    end

    def on_rescue(constants, assign, body, d)
      constants ||= []
      rescue_body = RescueBodyExpression.wrap(body)
      src = extract_src_by_tokens(pop_keyword('rescue'), rescue_body)
      RescueExpression.new(constants.each.to_a, assign, rescue_body, d, src)
    end

    def on_ensure(body)
      EnsureExpression.new(body, extract_src_by_tokens(pop_keyword('ensure'), body))
    end

    def on_bodystmt(body, rescue_exp, c, ensure_exp)
      BodystmtExpression.new(body, rescue_exp, c, ensure_exp, src: extract_src_by_tokens(body, body))
    end

    def on_stmts_new
      BodyExpression.new(extract_src(lineno(), column()))
    end

    def on_stmts_add(body, statement)
      assert body.kind_of?(BodyExpression), "Expected body #{body} to be type of BodyExpression"
      body.add(statement)
    end

    def on_defined(body)
      DefinedExpression.new(body, extract_src_by_tokens(pop_keyword('defined?'),body))
    end

    def on_program(body)
      RootExpression.new(body, @src)
    end

    def on_operator_ambiguous(value, msg)
      token = Token.new(:op, value.to_s, extract_src_by_value(value))
      AmbiguousOperatorExpression.new(token, msg, extract_src_by_token(token))
    end

    def on_magic_comment(key, value)
      MagicCommentExpression.new(key, value, extract_src(lineno(), column()))
    end

    def compile_error(msg)
      raise CodeMiner::ParseError, msg
    end

    private

    def extract_src_by_token(token, line=lineno(), col=column())
      SourceExtract.extract_by_token(@src, token, line, col)
    end

    def extract_src_by_tokens(begin_token, end_token=begin_token)
      SourceExtract.extract_by_tokens(@src, begin_token, end_token)
    end

    def extract_src_by_value(value)
      extract_src(lineno(), column(), lineno(), column() + value.length)
    end

    def extract_src(begin_line, begin_column, end_line=lineno(), end_column=column())
      SourceExtract.new(@src, begin_line, begin_column, end_line, end_column)
    end

    def extract_params_source(params)
      extract_src(params.first.line, params.last.line, params.first.column, params.last.column)
    end

    def assert(t, msg)
      raise CodeMiner::ParseError, msg unless t
    end

    def pop_keyword(type)
      i = @keywords.index {|k| k.value == type }
      @keywords.delete_at(i)
    end

  end

end
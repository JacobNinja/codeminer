Gem::Specification.new do |s|
  s.name = 'codeminer'
  s.version = '0.1.0'
  s.date = '2014-06-30'

  s.summary = 'summary'
  s.description = 'description'

  s.authors = ['Jacob Richardson']
  s.email = 'jacob.ninja.dev@gmail.com'

  s.require_paths = %w[lib]

  s.add_development_dependency('test-unit', '2.5.5')

  s.files = %w[
    codeminer.gemspec
    lib/codeminer.rb
    lib/codeminer/parser.rb
    lib/codeminer/expression_processor.rb
    lib/codeminer/source_extract.rb
    lib/codeminer/token.rb
  ]
  s.files += Dir.glob('lib/codeminer/expressions/*.rb')
  s.files += Dir.glob('lib/codeminer/processors/*.rb')

end

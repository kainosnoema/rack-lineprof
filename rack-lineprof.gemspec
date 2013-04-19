$: << File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rack-lineprof'
  s.version     = '0.0.1'
  s.description = 'Rack middleware for rblineprof (github.com/tmm1/rblineprof)'
  s.summary     = 'Makes line-by-line source code profiling easy.'
  s.license     = 'MIT'

  s.files       = Dir['lib/**/*']

  s.has_rdoc    = false

  s.authors     = ['Evan Owen']
  s.email       = %w[kainosnoema@gmail.com]
  s.homepage    = 'https://github.com/kainosnoema/rack-lineprof'

  s.add_dependency 'rack'
  s.add_dependency 'rblineprof', '~> 0.3.1'
  s.add_dependency 'term-ansicolor'
end

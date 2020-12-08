#!/usr/bin/ruby
require_relative 'lib/linter'
linter = Linter.new(ARGV[0] || Dir.getwd)
linter.lint

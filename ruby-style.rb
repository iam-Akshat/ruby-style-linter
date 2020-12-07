#!/usr/bin/ruby
require_relative 'lib/linter.rb'
linter = Linter.new(ARGV[0] || Dir.getwd)
linter.lint

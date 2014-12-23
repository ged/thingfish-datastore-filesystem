#!/usr/bin/ruby
# coding: utf-8

BEGIN {
	require 'pathname'
	basedir = Pathname( __FILE__ ).dirname.parent

	thingfishdir = basedir.parent + 'Thingfish'
	thingfishlib = thingfishdir + 'lib'

	strelkadir = basedir.parent + 'Strelka'
	strelkalib = strelkadir + 'lib'

	$LOAD_PATH.unshift( thingfishlib.to_s ) if thingfishlib.exist?
	$LOAD_PATH.unshift( strelkalib.to_s ) if strelkalib.exist?
}


# SimpleCov test coverage reporting; enable this using the :coverage rake task
require 'simplecov' if ENV['COVERAGE']

require 'loggability'
require 'loggability/spechelpers'
require 'configurability'
require 'configurability/behavior'

require 'rspec'
require 'thingfish'
require 'thingfish/spechelpers'

Loggability.format_with( :color ) if $stdout.tty?


### Mock with RSpec
RSpec.configure do |c|
	include Thingfish::SpecHelpers
	include Thingfish::SpecHelpers::Constants

	c.run_all_when_everything_filtered = true
	c.filter_run :focus
	c.order = 'random'
	c.mock_with( :rspec ) do |mock|
		mock.syntax = :expect
	end

	c.include( Loggability::SpecHelpers )
end

# vim: set nosta noet ts=4 sw=4:


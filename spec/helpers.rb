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

require 'fakefs/spec_helpers'
require 'fakefs/safe'

require 'rspec'
require 'thingfish'
require 'thingfish/spechelpers'

Loggability.format_with( :color ) if $stdout.tty?


# Monkeypatch missing functionality into FakeFS

module FakeFS

# 	# Delegate ::size to File::size
# 	module FileTest
# 		def self::size( filename )
# 			File.size( filename )
# 		end
# 	end

	# A bunch of 2.x fixes
	class File < StringIO
		def self::size( path )
			read( path ).bytesize
		end

	    def initialize(path, mode = READ_ONLY, _perm = nil, opts = {})
	      @path = path
	      @mode = mode.is_a?(Hash) ? (mode[:mode] || READ_ONLY) : mode
	      @file = FileSystem.find(path)
	      @autoclose = true
		  @opts = opts

	      check_modes!

	      file_creation_mode? ? create_missing_file : check_file_existence!

	      super(@file.content, @mode)
	    end
	end

# 	# Make some Pathname method use File instead of IO
# 	class Pathname
#
# 		def read( *args )
# 			File.read( self.to_s, *args )
# 		end
#
# 		# Removes a file or directory, using <tt>File.unlink</tt> or
# 		# <tt>Dir.unlink</tt> as necessary.
# 		def unlink()
# 			if File.directory?( @path )
# 				Dir.unlink @path
# 			else
# 				File.unlink @path
# 			end
# 		end
# 	end

end # module FakeFS



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


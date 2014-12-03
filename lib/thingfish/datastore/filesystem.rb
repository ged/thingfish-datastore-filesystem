# -*- ruby -*-
#encoding: utf-8

require 'fileutils'
require 'tmpdir'
require 'configurability'
require 'thingfish/datastore'
require 'strelka/mixins'


# A hashed-directory hierarchy filesystem datastore for Thingfish
class Thingfish::Datastore::Filesystem < Thingfish::Datastore
	extend Configurability,
	       Loggability,
	       Strelka::MethodUtilities,
	       Thingfish::Normalization

	# Package version
	VERSION = '0.0.1'

	# Version control revision
	REVISION = %q$Revision$

	# The number of subdirectories to use in the hashed directory tree. Must be 2, 4, or 8
	HASH_DEPTH = 4

	# Configurability API -- default configuration
	DEFAULT_CONFIG = {
		root_path: Pathname( Dir.tmpdir ),
	}


	# Loggability API -- log to the thingfish logger
	log_to :thingfish

	##
	# The directory to use for the datastore
	singleton_attr_accessor :root_path
	@root_path = DEFAULT_CONFIG[ :root_path ]


	# Configurability API -- the section of the config to use
	config_key :filesystem_datastore


	### Configurability API -- configure the filesystem datastore.
	def self::configure( config=nil )
		config = self.defaults.merge( config || {} )

		self.root_path = Pathname( config[:root_path] )
		raise ArgumentError, "root path %s does not exist" % [ self.root_path ] unless
			self.root_path.exist?
	end


	### Create a new Filesystem Datastore.
	def initialize
		super
		@root_path = self.class.root_path
	end


	######
	public
	######

	##
	# The root path of the datastore
	attr_reader :root_path



	### Save the +data+ read from the specified +io+ and return an ID that can be
	### used to fetch it later.
	def save( io )
		oid = make_object_id()

		pos = io.pos
		self.store( oid, io )

		return oid
	ensure
		io.pos = pos if pos
	end


	#########
	protected
	#########

	### Move the file behind the specified +io+ into the datastore.
	def store( oid, io )
		storefile = self.hashed_path( oid )
		storefile.dirname.mkpath

		if io.respond_to?( :path )
			self.move_spoolfile( io.path, storefile )
		else
			spoolfile = self.spool_to_tempfile( io, storefile )
			self.move_spoolfile( spoolfile, storefile )
		end
	end


	### Generate a Pathname for the file used to store the data for the
	### resource with the specified +oid+.
	def hashed_path( oid )
		oid = oid.to_s

		# Split the first 8 characters of the UUID up into subdirectories, one for
		# each HASH_DEPTH
		chunksize = 8 / HASH_DEPTH
		hashed_dir = 0.step( 7, chunksize ).inject( self.root_path ) do |path, i|
			path + oid[i, chunksize]
		end

		return hashed_dir + oid
	end


	### Move the file at the specified +source+ path to the +destination+ path using
	### atomic system calls.
	def move_spoolfile( source, destination )
		self.log.debug "Moving %s to %s" % [ source, destination ]
		FileUtils.move( source.to_s, destination.to_s )
	end


	### Spool the data from the given +io+ to a temporary file based on the
	### specified +storefile+.
	def spool_to_tempfile( io, storefile )
		extension = "-%d.%5f.%s.spool" % [ Process.pid, Time.now.to_f, SecureRandom.hex(6) ]
		spoolfile = storefile.dirname + (storefile.basename.to_s + extension)
		spoolfile.open( IO::EXCL|IO::CREAT|IO::WRONLY, 0600, encoding: 'binary' ) do |fh|
			IO.copy_stream( io, fh )
		end

		return spoolfile
	end

end # module Thingfish::Datastore::Filesystem


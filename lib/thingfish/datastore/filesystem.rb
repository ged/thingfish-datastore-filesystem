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
	VERSION = '0.2.2'

	# Version control revision
	REVISION = %q$Revision: 6fd20473c7d7 $

	# The number of subdirectories to use in the hashed directory tree. Must be 2, 4, or 8
	HASH_DEPTH = 4

	# Loggability API -- log to the thingfish logger
	log_to :thingfish

	# Configurability API -- set up settings and defaults
	configurability( 'thingfish.filesystem_datastore' ) do

		##
		# The directory to use for the datastore
		setting :root_path, default: Pathname( Dir.tmpdir ) + 'thingfish' do |val|
			Pathname( val ) if val
		end
	end


	### Create a new Filesystem Datastore.
	def initialize
		super
		@root_path = self.class.root_path
		raise ArgumentError, "root path %s does not exist" % [ @root_path ] unless @root_path.exist?
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


	### Fetch the data corresponding to the given +oid+ as an IOish object.
	def fetch( oid )
		return self.retrieve( oid )
	end


	### Returns +true+ if the datastore has a file for the specified +oid+.
	def include?( oid )
		return self.hashed_path( oid ).exist?
	end


	### Remove the data associated with +oid+ from the Datastore.
	def remove( oid )
		return self.hashed_path( oid ).unlink
	end


	### Replace the existing object associated with +oid+ with the data read from the
	### given +io+.
	def replace( oid, io )
		pos = io.pos
		self.store( oid, io )

		return true
	ensure
		io.pos = pos if pos
	end



	#########
	protected
	#########

	### Move the file behind the specified +io+ into the datastore.
	def store( oid, io )
		storefile = self.hashed_path( oid )
		FileUtils.mkpath( storefile.dirname.to_s, :mode => 0711 )

		if io.respond_to?( :path )
			self.move_spoolfile( io.path, storefile )
		else
			self.log.debug "Spooling in-memory upload to %s" % [ storefile.to_s ]
			spoolfile = self.spool_to_tempfile( io, storefile )
			self.move_spoolfile( spoolfile, storefile )
		end
	end


	### Look up the file corresponding to the specified +oid+ and return a
	### File for it.
	def retrieve( oid )
		storefile = self.hashed_path( oid )
		return nil unless storefile.exist?
		return storefile.open( 'r', encoding: 'binary' )
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
		io.rewind

		extension = "-%d.%5f.%s.spool" % [ Process.pid, Time.now.to_f, SecureRandom.hex(6) ]
		spoolfile = storefile.dirname + (storefile.basename.to_s + extension)
		spoolfile.open( IO::EXCL|IO::CREAT|IO::WRONLY, 0600, encoding: 'binary' ) do |fh|
			bytes = IO.copy_stream( io, fh )
			self.log.debug "Copied %d bytes." % [ bytes ]
		end

		return spoolfile
	end

end # module Thingfish::Datastore::Filesystem


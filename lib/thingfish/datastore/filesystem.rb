# -*- ruby -*-
#encoding: utf-8

require 'tmpdir'
require 'configurability'
require 'thingfish/datastore'
require 'strelka/mixins'


# A hashed-directory hierarchy filesystem datastore for Thingfish
class Thingfish::Datastore::Filesystem < Thingfish::Datastore
	extend Configurability,
	       Strelka::MethodUtilities,
	       Thingfish::Normalization

	# Package version
	VERSION = '0.0.1'

	# Version control revision
	REVISION = %q$Revision$

	# Configurability API -- default configuration
	DEFAULT_CONFIG = {
		hash_depth: 4,
		root_path: Dir.tmpdir,
	}


	##
	# The number of subdirectories to use in the hashed directory hierarchy.
	singleton_attr_accessor :hash_depth
	@hash_depth = DEFAULT_CONFIG[ :hash_depth ]

	##
	# The directory to use for the datastore
	singleton_attr_accessor :root_path
	@root_path = DEFAULT_CONFIG[ :root_path ]


	# Configurability API -- the section of the config to use
	config_key :filesystem_datastore


	### Configurability API -- configure the filesystem datastore.
	def self::configure( config=nil )
		config = self.defaults.merge( config || {} )

		self.hash_depth = config[:hash_depth]
		raise "Max hash depth (8) exceeded" if self.hash_depth > 8
		raise "Hash depth must be 1, 2, 4, or 8." unless [ 1, 2, 4, 8 ].include?( self.hash_depth )

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

	# The root path of the datastore
	attr_reader :root_path


	### Save the +data+ read from the specified +io+ and return an ID that can be
	### used to fetch it later.
	def save( io )
		oid = make_object_id()

		self.store( io )

		return oid
	end


	#########
	protected
	#########

	### Move the file behind the specified +io+ into the datastore.
	def store( io )
		
	end


end # module Thingfish::Datastore::Filesystem


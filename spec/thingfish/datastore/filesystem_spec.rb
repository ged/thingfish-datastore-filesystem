#!/usr/bin/env ruby

require_relative '../../helpers'

require 'fileutils'
require 'rspec'

require 'thingfish/behaviors'
require 'thingfish/datastore/filesystem'


describe Thingfish::Datastore::Filesystem do

	before( :each ) do
		@testing_root_path = described_class.defaults[:root_path]
		@testing_root_path.mkpath
		described_class.configure( root_path: @testing_root_path )
	end

	after( :each ) do
		@testing_root_path.rmtree
	end


	let( :test_spoolfile ) { @testing_root_path + 'test_io' }
	let( :file_io ) do
		io = test_spoolfile.open( 'w+' )
		io.print( TEST_PNG_DATA )
		io.rewind
		io
	end

	let( :store ) { Thingfish::Datastore.create(:filesystem) }


	it_behaves_like "a Thingfish datastore"


	it "has a default root" do
		expect( described_class.root_path ).to_not be_nil
	end


	it "raises an exception if the configured root directory doesn't exist" do
		expect {
			described_class.configure( root_path: '/nonexistent' )
		}.to raise_error( ArgumentError, /root path \/nonexistent does not exist/ )
	end


	it "stores an IO with a path by moving it into place" do
		new_uuid = store.save( file_io )

		rval = store.fetch( new_uuid )
		expect( rval ).to respond_to( :read )
		expect( rval.read ).to eq( TEST_PNG_DATA )

		expect( test_spoolfile ).to_not exist
	end


end

# vim: set nosta noet ts=4 sw=4 ft=rspec:

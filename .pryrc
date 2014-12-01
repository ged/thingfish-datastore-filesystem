#!/usr/bin/ruby -*- ruby -*-

require 'configurability'
require 'loggability'
require 'pathname'

$LOAD_PATH.unshift( '../Strelka/lib', '../Thingfish/lib', 'lib' )

begin
	require 'thingfish/datastore/filesystem'

	Loggability.level = :debug
	Loggability.format_with( :color )

rescue Exception => e
	$stderr.puts "Ack! Libraries failed to load: #{e.message}\n\t" +
		e.backtrace.join( "\n\t" )
end



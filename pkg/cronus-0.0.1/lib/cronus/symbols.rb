require "keystone"

module Cronus
	
	@@pipeline ||= ::Keystone.bootstrap("#{File.dirname(__FILE__)}/../../config/assets.rb")
	
	def self.keystone_compiler
		@@keystone_compiler ||= @@pipeline.compiler("cronus.js")
	end

end

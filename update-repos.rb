#!/usr/bin/env ruby
# Module Management Script, by Chris Olstrom <chris@olstrom.com>
# Make changes to modules.conf, and run this script to merge the latest version.
# This version uses git clone/pull, and does not depend on git-subtree.

require "yaml"

modules = YAML.load_file("modules.conf")

if ARGV[0] === "init" then command = "clone" else command = "pull" end

case command
	when "clone"
		modules.each do |name, data|
			puts "Working on module #{name}"
			puts `git #{command} #{data['remote']} #{name} && cd #{name} && git checkout #{data['version']}`
		end
	end
	when "pull"
		modules.each do |name, data|
			puts "Working on module #{name}"
			puts `cd #{name} && git #{command} && git checkout #{data['version']}`
		end
	end
end


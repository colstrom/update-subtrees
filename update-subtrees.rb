#!/usr/bin/env ruby
# Module Subtree Management Script, by Chris Olstrom <chris@olstrom.com>
# Make changes to modules.conf, and run this script to merge the latest version.

require "yaml"

modules = YAML.load_file("modules.conf")

if ARGV[0] === "init" then command = "add" else command = "pull" end

modules.each do |name, data|
	puts "Working on module #{name}"
	puts `git subtree #{command} --prefix #{name} #{data['remote']} #{data['version']} --squash`
end

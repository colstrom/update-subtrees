#!/usr/bin/env ruby
# Module Merge Script, by Chris Olstrom <chris@olstrom.com>
# Make changes to modules.conf, this script will construct a unionfs from the modules.

require "yaml"

modules = YAML.load_file("modules.conf")
repo_root = "/path/to/modules"
union_destination = "/path/to/merged/project"

union_paths = ""
modules.each do |name, data|
	union_paths.prepend "#{repo_root}/#{name}:"
end

command = {
	umount: "sudo umount #{union_destination}",
	mount: "sudo mount -t aufs -o br=#{union_paths} none #{union_destination}"
}

puts `#{command[:umount]}; #{command[:mount]}

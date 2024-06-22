#!/usr/bin/ruby

# this program MUST be ran from
# the root folder of the overlay
# e.g. "./bin/index.rb"

# this program indexes all packages
# in an overlay and puts it into
# a file which can be used by
# external sources.

# if you have unwanted entries getting in to the file, add them here to ignore them
ignore = [".", "..", ".git", "metadata", "profiles", "bin"]
categories = []
packages = []

# detects if a file is a file or a directory
# and if it is a file, adds it to ignore
Dir.foreach('.') do |filename|
  if File.directory?(filename) == false
    ignore << filename
  end
end

# this assumes that the program is being run
# from the root of the overlay
Dir.foreach('.') do |filename|
  if ignore.include?(filename) == true
    next
  end
  categories << filename
end

for i in categories
  Dir.foreach(i) do |filename|
    if ignore.include?(filename) == true
      next
    elsif File.directory?(filename) == false
      ignore << filename
      next
    end
    packages << i + "/" + filename
  end
end

packages = packages.join("\n")

File.write("packages", packages)

puts "List of packages generated."

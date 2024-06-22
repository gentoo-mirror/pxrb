#!/usr/bin/ruby

#Copyright (c) 2024 pxrb

#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# This program must be ran from
# the root folder of the overlay
# and assumes that it is

# This program indexes all packages
# in an overlay and puts it into
# a file.

# If you have unwanted entries getting in to the file, add them here to ignore them
ignore = [".", "..", ".git", "metadata", "profiles"]
categories = []
packages = []

# Detects if a file is a file or a directory
# and if it is a file, adds it to ignore
Dir.foreach('.') do |filename|
  if File.directory?(filename) == false
    ignore << filename
  end
end

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
    elsif File.directory?(i + "/" + filename) == false
      ignore << filename
      next
    end
    packages << i + "/" + filename
  end
end

packages = packages.join("\n")

File.write("packages", packages)

puts "List of overlay packages generated."

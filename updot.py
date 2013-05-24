#!/usr/local/bin/python

# Author: Mike Grimes <magrimes@mtu.edu> 5-23-2013
#
# A script I made to automatically grab all of the dotfiles I want to keep
# track of, and push them upto my github repository. Files to be updated
# should be included in a 'dotfiles.manifest' file, in the same directory
# as this script.

# open manifest file

from subprocess import call
import os.path
import string
from github3 import authorize
from getpass impor getuser, getpass

manifest = open('dotfiles.manifest', 'r');

# copy each file to dotfiles
total_files = 0;

print "Copying files:"
for path in manifest:
	path = string.rstrip(path, "\n")
	total_files += 1
	fullpath = os.path.expanduser(path)
	print fullpath
	
	if os.path.isfile(fullpath) or os.path.isdir(fullpath):
		print "%s exists!" % fullpath
		#call(["cp", "-v", line, "."])
	else:
		print "%s is not a currently existing file" % fullpath
		"or directory, skipping."

print "Total number of items updated: %d " % total_files
   #call(["cp", "-v", line, "~/dotfiles/"])


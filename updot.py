#!/usr/local/bin/python

# Author: Mike Grimes <magrimes@mtu.edu> 5-23-2013
#
# A script I made to automatically grab all of the dotfiles I want to keep
# track of, and push them upto my github repository. Files to be updated
# should be included in a 'dotfiles.manifest' file, in the same directory
# as this script.

# open manifest file

from subprocess import call, check_output
import os.path
import string
import filecmp
import sys

# for some reason I can't import github3 just after installing it, so we add
# it to the system path
sys.path.append("/usr/local/lib/python2.7/site-packages")

manifest = open("dotfiles.manifest", "r");

# copy each file to dotfiles
total_files = 0;
updated_files = 0;
invalid_files = 0;
new_files = 0;
# print "Copying files:"
for path in manifest:
    path = string.rstrip(path, "\n")
    total_files += 1
    fullpath = os.path.expanduser(path)
    # print fullpath

    if os.path.isfile(fullpath) or os.path.isdir(fullpath):
        filename = string.lstrip(os.path.basename(fullpath), ".")
        filename = os.getcwd() + "/" + filename
        if os.path.isfile(filename):
        # file is already in directory, but before we update it
        # we first check if there are any changes to the file
            if filecmp.cmp(fullpath, filename):
                # files are same, no need to update
                print "%s is up to date, skipping. " \
                    % os.path.basename(filename)
            else:
                # print "COPY %s" % os.path.basename(filename)
                # files are different, update
                call(["cp", "-v", fullpath, filename])
		call(["git", "add", filename])
        else:
            # file is not in directory, we'll copy it and commit it
            new_files += 1
    else:
        total_files -= 1
        invalid_files += 1
        print "%s is not an existing file or directory" % fullpath
        ", skipping."

call(["git", "add", "dotfiles.manifest"])
call(["git", "commit", "-m", "updot.py update"])
call(["git", "push"])

print "Files updated: %d / %d (%d invalid)" % (updated_files, total_files, \
                invalid_files)

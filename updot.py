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
from github3 import authorize, login
from getpass import getuser, getpass
import sys

# for some reason I can't import github3 just after installing it, so we add
# it to the system path
sys.path.append("/usr/local/lib/python2.7/site-packages")

user = "magrimes" # your github username here, otherwise it will prompt
repo = "dotfiles" # name of github repo with your dotfiles in it

while not user:
    user = raw_input("Github username: ")

CREDENTIALS_FILE = user + ".updot"

if os.path.isfile(CREDENTIALS_FILE): # user has authenticated with github before
    with open(CREDENTIALS_FILE, "r") as fd:
        token = fd.readline().strip()
        github_id = fd.readline().strip()
    gh = login(token=token)

else:   # user hasn't, so we ask for password

    password = ""
    while not password:
        password = getpass("Password for {0}: ".format(user))

    scopes = ["user", "repo"]

    note = "updot.py, a script that utilizes github3.py"

    gh = login(user, password)
    auth = authorize(user, password, scopes, note, None)

    with open(CREDENTIALS_FILE, "w") as fd:
        fd.write(auth.token + "\n")
        fd.write(str(auth.id))

# we are now logged in

dotfiles_repo = gh.repository(user, repo)

manifest = open('dotfiles.manifest', 'r');

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
                print "%s is up to date, skipping. " + \
                    os.path.basename(filename)
            else:
                # print "COPY %s" % os.path.basename(filename)
                # files are different, update
                call(["cp", "-v", fullpath, filename])
        else:
            # file is not in directory, we'll copy it and commit it
            new_files += 1
    else:
        total_files -= 1
        invalid_files += 1
        print "%s is not an existing file or directory" % fullpath
        ", skipping."

call(["git", "add", "."])
call(["git", "commit", "-m", "updot.py update"])
call(["git", "push"])

print "Files updated: %d / %d (%d invalid)" % (updated_files, total_files, \
                invalid_files)
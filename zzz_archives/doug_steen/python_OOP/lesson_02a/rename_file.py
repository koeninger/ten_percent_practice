#!/usr/bin/env python

##################
#  Rename a list of files
##################

import os 

def rename_files():
    saved_path = os.getcwd()        # get current working directory

    file_path = "/Users/dsteen/fm-repos/ten_percent_practice/doug_steen/python_OOP/lesson_02a/prank"

#  get list of file names from a folder
    file_list = os.listdir(file_path)

    os.chdir(file_path)

#  rename each file
    for file_name in file_list:
        new_file_name = file_name.translate(None,"0123456789")
        print("renaming {0} to {1}".format(file_name, new_file_name))
        os.rename(file_name, new_file_name)

    os.chdir(saved_path)

rename_files()

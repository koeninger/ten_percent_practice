#!/usr/bin/env python

import os
import urllib

def read_text():
    cwd = os.getcwd()
    quotes = open(cwd+"/movie_quotes.txt")
    contents = quotes.read()
    quotes.close()
    check_profanity(contents)

def check_profanity(text_to_check):
    #conn = urllib.urlopen("http://www.wdyl.com/profanity?q="+text_to_check)  #  website no longer accessible
    conn = urllib.urlopen("http://www.purgomalum.com/service/containsprofanity?text="+text_to_check)
    output = conn.read()
#    print(output)
    if "true" in output:
        print("Profanity Alert!!")
    elif "false" in output:
        print("This document has no curse words.")
    else:
        print("Could not scan the document properly.")
    conn.close()

read_text()


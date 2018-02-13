import sys
import urllib2
import urlparse
import htmllib, formatter
from cStringIO import StringIO

class Spider:
    def __init__(self, startURL, log=none):
        # set initial values
        self.URLs = set()
        self.URLS.add(startURL)
        self.include = startURL
        self._links_to_process = [startURL]
        if log is None:
            #Use log_stdout function if no log provided
            self.log = log_stdout
        else:
            self.log = log
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
TOP_DIR = os.path.dirname(os.path.realpath(os.path.expanduser(__file__)))
import sys
sys.path.insert(0, os.path.join(TOP_DIR, "utils"))




import subprocess
import re
import os
import copy
import tempfile
import shutil
import optparse

import utils.moduleintrospection as introspection

def run(cmd,tmpfile=True,currenv=False,verbose=False):
    if verbose : print "running command--->"+cmd 
    if(currenv):
        #print "command--->"+cmd 
        args=cmd.split()
    else:
	if(tmpfile):
		tmp=tempfile.mktemp()
	#        print "using tmpfile-->"+tmp
		f=open(tmp,"w")
		f.write(cmd)
		f.flush()
		f.close()
		#args=["/bin/bash", "-i", tmp]
		args=["/bin/bash",  tmp]
	else:
		#args=["/bin/bash", "-i","-c",cmd]
		args=["/bin/bash", "-c",cmd]
    if verbose : print "run...args:",args
    myprocess = subprocess.Popen(args,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    stdout,stderr = myprocess.communicate()
    myprocess.wait()
    #print "out-->"+stdout
    if stderr : 
	 print "err-->"+stderr
	 exit(1)
    return (stdout,stderr)

##########################

class ba_deploy():
    def __init__(self):
        self.clustername=introspection.myintrospect().sysintro['hostname'].split('.')[1:][0:1][0]
        self.op=optparse.OptionParser( usage="usage: %prog [options] config file" )
        self.op.add_option('-v','--verbose',action="store_true", dest='verbose',default=False,help=' print output of build steps')
        self.op.add_option('-s','--stop_on_error',action="store_true", dest='stop_on_error',default=False,help=' stop build steps on error')

    def parse(self,argv=None):
        if not argv:
            (opts,args) = self.op.parse_args(argv)
        else:
            (opts,args) = self.op.parse_args()

        
        if len(args) > 0: conf_file=args[0] 
        else : conf_file=os.path.join('.','config.cfg')


if __name__ == '__main__':
    bab=ba_deploy()
    bab.parse()


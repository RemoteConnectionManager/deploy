#!/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re
import os
import copy
import tempfile
import shutil
import optparse

import moduleconfig
import moduleintrospection

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

class matcher():
    def __init__(self,matcher,instate=None,outstate=None,action=None):
        self.matcher=re.compile(regstring)
        self.instate=instate
        self.outstate=outstate
        self.action=action
    def match(self,line):
        match=self.matcher(line)
        
###########
        
class ba_helper():

    def __init__(self,verbose=False):
        self.verbose=verbose
        (out,err)=run("ba -b",verbose=self.verbose)   
        if(err):
            print "ba command not found, try module load ba"
            exit()
        else:
	    if self.verbose:
	        print "ba controlled modules\n"+out
        self.base_options={
            'build.minor_release_support' : 'False',
            '--modulefile-schema' : 'single',
            '--category' : None,
            '--compiler' : None,
            '--license-type' : 'unknown',
            '--build-author' : 'unknown',
            '--pkg-name' : None ,
            '--pkg-version' : None ,
            '--short-description' : None ,
            '--long-description' : 'Long Descripion Unavailable' ,
            '--homepage-url' : 'Hompage URL Unavailable' ,
            '--download-url' : None ,

        }

        self.multiple_options={
            '--required-modules' : None ,

        }
        self.options=copy.copy(self.base_options)
        self.options.update(self.multiple_options)
        self.configfile=None
        self.attribs={
          'build_dir':'_INTERNAL_',
          'module_file':'_INTERNAL_',
          'work_dir':'_INTERNAL_',
          'module_dir':'_INTERNAL_',
          'prefix_dir':'build.configure'
        }
        for i in self.attribs:
            setattr(self,i,None)
        self.editfiles={
            'BUILD_SCRIPT':None,
            'MODULEFILE':None
        }
        for i in self.editfiles:
            setattr(self,i,None)

        self.name=''
        self.prefix=''
	self.replaces=dict()
        self.stop_on_error_lines="set -e\nset -o errexit\n"
        self.skip=False
        
    def merge_options(self,options=dict()):
        for o in self.options:
            replace=options.get(o,None)
            if(replace):
                self.options[o]=replace
            else:
                replace=options.get(o.strip('-'),None)
                if(replace):
                    self.options[o]=replace

    def set_replaces(self,rep=None):
        if(rep): self.replaces=rep
	
    def create(self):
        command='ba create -f '
        for o in self.base_options:
            val=self.options.get(o,None)
            if(val):
                #command+=' '+o+'='+'"'+val.replace('\n',' ')+'"'
                command+=' '+o+'='+'"'+val+'"'
            else:
                print "ERROR param->"+o+"<  UNDEFINED"
                return 
        for o in self.multiple_options:
            val=self.options.get(o,None)
            if(val):
                for s in val.split(' '):
                    command+=' '+o+'='+'"'+s+'"'

        #print "running-->"+command+"<--"
        #print 
        (out,err)=run(command,True,verbose=self.verbose)        
        regpath=re.compile(r"^Config file\s*'(?P<path>.*?)'")
        for l in out.splitlines():
#            print "line--->"+l
            m=regpath.match(l)
            if(m):
                path=m.group('path')
                print "path--->"+path
                self.configfile=path
        if(self.configfile):
            for attr in self.attribs:
                (out,err)=run("ba query "+self.attribs[attr]+"."+attr+" -i "+self.configfile+" | sed s/^[^=]*=//",verbose=self.verbose)
                path=out.strip()
     #           if(os.path.exists(path)): 
                setattr(self,attr,path)
                print "setting "+attr+" -->"+path 
        for ef in self.editfiles:
	    fname=os.path.join(self.build_dir,ef)
            if(os.path.exists(fname)): 
	        prev_file=fname+'.orig'
		shutil.copyfile(fname,prev_file)

    
    def exec_build_passes(self,passes=[],report=False):
        buildfile=os.path.join(self.build_dir,'BUILD_SCRIPT')
	
	if os.path.exists(buildfile):
            for p in ['download','configure','make','install']:
	        if p in passes:
		    cmd="/bin/bash "+buildfile+" --"+p          
                    results=dict()
                    msg="pass "+p
                    for r in ['out','err']:
                        results[r]=[os.path.join(self.build_dir,p+'_'+r+'.log'),'']
                        msg += "\n  " + r+" in "+results[r][0]
                    msg += "\n  run-->"+cmd
                    print msg
	            (results['out'][1],results['err'][1])=run(cmd,currenv=True,verbose=self.verbose)
                    for r in ['out','err']:
		        if results[r][1] :
			    if report : print results[r][1]
		            with open (results[r][0], "w") as myfile:
                                myfile.write(results[r][1])

		
    def setname(self,line='',groups=dict(),match=None):
        self.out += self.prefix+line+'\n'
        name=groups.get('name',None)
        if(name): self.name=name
    
    def start(self,line='',groups=dict(),match=None):
        code=self.replaces.get(self.name,None)
        self.out += self.prefix+line+'\n'
	if(code): self.prefix=''
	self.skip=True
    
    def stop(self,line='',groups=dict(),match=None):
        code=self.replaces.get(self.name,None)
	if(code):
            for nl in code.splitlines():
                self.out += "    "+nl+'\n'
        self.prefix=''
        self.out += self.prefix+line+'\n'
        self.skip=False

    def force_replace(self,line='',groups=dict(),match=None):
#        print "force_replace:",groups,match
        replace=groups.get('replace',None)
        if replace:            
            self.out += self.prefix+line.replace(replace,self.replaces.get(match,''))+'\n'
        else:
            self.out += self.prefix+line+'\n'

    def replace(self,line='',groups=dict(),match=None):
        name=groups.get('name','')
        replace=groups.get('replace',name)
        matches=[match]
        if(name): matches.append(match+'.'+name.lower())
        for m in matches:
	    #print "calling replace name->"+str(name)+"<- match ->"+str(m)+"<- replace ->"+replace
	    code=self.replaces.get(m,None)
	    if code:
                self.out += self.prefix+line.replace(replace,code)+'\n'
                return
	self.out += self.prefix+line+'\n'
    
    def parse(self,repls=dict(),stop_on_error=False):

        header=re.compile(r'^\s*ba_header\s*"(?P<name>.*?)"')
        start=re.compile(r'^\s*#*\s*vvv\s*#*')
        stop=re.compile(r'^\s*#*\s*\^\^\^\s*#*')
        pkg_source_dir=re.compile(r'^\s*BA_PKG_SOURCE_DIR\s*="(?P<name>.*?)"')
        redirect_line=re.compile(r'^\s*}\s+(?P<replace>2>&1\s+\|\s+tee\s+\-a\s+\"\$BA_PKG_BUILD_LOG\")')
        module_setenv_home=re.compile(r'^(?P<name>#\s*setenv)\s+[A-Z0-9_]*HOME\s*".*"') 
        module_prepend_path=re.compile(r'^(?P<replace>#\s*prepend-path)\s+(?P<name>[A-Z_]*)\s+".*"') 
        module_conflict=re.compile(r'^(?P<name>#\s*conflict)\s+') 
        module_prereq=re.compile(r'^(?P<replace>#\s*ba_modules_prereq)\s+(?P<name>.*)$') 
        module_conflict_comment=re.compile(r'^(?P<replace># conflicting modules:)') 
        
        self.matches=dict()
        self.matches[header]=(self.setname,'header')
        self.matches[start]=(self.start,'start')
        self.matches[stop]=(self.stop,'stop')
        self.matches[pkg_source_dir]=(self.replace,'pkg_source_dir')
        if stop_on_error : self.matches[redirect_line]=(self.force_replace,'redirect_line')
        self.matches[module_setenv_home]=(self.replace,'setenv_home')
        self.matches[module_conflict_comment]=(self.replace,'conflict_comment')
        self.matches[module_conflict]=(self.replace,'conflict')
        self.matches[module_prepend_path]=(self.replace,'prepend_path')
        self.matches[module_prereq]=(self.replace,'prereq')
        #print "error-->"+err+"<--"

        for ef in self.editfiles:
	  if(ef in repls):
            if not self.build_dir : 
                print "build dir undefined"
                exit()
	    fname=os.path.join(self.build_dir,ef)
            if(os.path.exists(fname)): 
                with open (fname, "r") as myfile:
                    input=myfile.read()
                print "writing: "+fname
                #print self.editfiles[ef]
                self.out=''
		self.replaces=repls.get(ef,dict())
		#print "----------- replaces---------"
		#print self.replaces
                linecount=0
                for l in input.splitlines():
                    if linecount==1 :
                        if stop_on_error: self.out += self.stop_on_error_lines
                        self.out += self.replaces.get('reproduce_string','')

                    linecount+=1
                    unhandled=True
                    for r in self.matches:
                        m=r.match(l)
                        if(m):
                            (a,n)=self.matches.get(r,(None,None))
                            #print "match ",n, " line -->",l
                            if(a):
                                 a(line=l,groups=m.groupdict(),match=n) 
                                 unhandled=False    

                    if unhandled:
		      if not self.skip:
                         self.out += self.prefix+l+'\n'
                #print self.out
                with open (fname, "w") as myfile:
                    myfile.write(self.out)

    def postprocess(self):
        if(self.configfile):
            command='ba postprocess -f -i ' + self.configfile
            (out,err)=run(command,currenv=True)
	    fname=os.path.join(self.build_dir,'MODULEFILE')
            if(os.path.exists(fname)): 
	        prev_file=fname+'.orig'
		shutil.copyfile(fname,prev_file)

    def module(self):
        if(self.configfile):
            command='ba module -f -i ' + self.configfile
            (out,err)=run(command,currenv=True,verbose=self.verbose)

class ba_builder():
    def __init__(self):
        self.build_passes=['download','configure','make','install']
        self.clustername=moduleintrospection.myintrospect().sysintro['hostname'].split('.')[1:][0:1][0]
        #['download','configure','make','install']
        self.op=optparse.OptionParser( usage="usage: %prog [options] config file" )
        for i in self.build_passes:
            self.op.add_option('-'+i[0],'--'+i,action="store_true", dest=i,default=False,help='execute '+i+' step ')

        self.op.add_option('-a','--build_all',action="store_true", dest='build_all',default=False,help=' execute all build steps')
        self.op.add_option('-v','--verbose',action="store_true", dest='verbose',default=False,help=' print output of build steps')
        self.op.add_option('-s','--stop_on_error',action="store_true", dest='stop_on_error',default=False,help=' stop build steps on error')
        self.op.add_option("--platform_template",action="store",type="string", dest="platform_template",default='unix',help=' set platform template file, default to unix')
        self.op.add_option("--build_template",action="store",type="string", dest="build_template",default=self.clustername,help=' set build template file, default to '+self.clustername)

    def parse(self,argv=None):
        if not argv:
            (opts,args) = self.op.parse_args(argv)
        else:
            (opts,args) = self.op.parse_args()

        
        if len(args) > 0: conf_file=args[0] 
        else : conf_file=os.path.join('.','config.cfg')
        if  opts.build_all: 
            bp=self.build_passes
        else:
            bp=[]
            for i in self.build_passes:
                if getattr(opts,i,False): bp.append(i)
        #print bp
        prld=[opts.platform_template,opts.build_template]
        #print prld

        cfg=moduleconfig.moduleconfig(init_parse=moduleconfig.preload(prld))
        cfg.parse(conf_file)
        module_opt=cfg.module_options()
    
        bah=ba_helper(verbose=opts.verbose)
        bah.merge_options(options=module_opt)
        #print "editfiles-->",list(bah.editfiles)
        bah.create()

        #print "###build_dir",bah.build_dir
        #print "###install_dir",bah.prefix_dir
        cfg.merge(
         moduleconfig.baseconfig(
          confdict={
            ('build','build_dir') : bah.build_dir,
            ('build','install_dir') : bah.prefix_dir,
            ('build','work_dir') : bah.work_dir,
            ('build','module_file') : bah.module_file,
          }
         )
        )
        #print opt
        build=cfg.file_replace(['BUILD_SCRIPT'])
        #print build
        module=cfg.file_replace(['MODULEFILE'])
        #print module


        bah.parse(build,opts.stop_on_error)
        bah.exec_build_passes(bp,opts.verbose)
        bah.postprocess()
        bah.parse(module)
        bah.module()


if __name__ == '__main__':
    bab=ba_builder()
    bab.parse()


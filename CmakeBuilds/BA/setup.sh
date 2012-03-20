module purge
module load autoload
module load profile/advanced
module load ba
module use /plx/userprod/pro3dwe1/BA/modulefiles/
module load cmake

SCRIPT_PATH="${BASH_SOURCE[0]}";
if([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null


curdir=`pwd`
user=`whoami`

if [ "$ba_test_user" = "" ]; then
  ba_test_user="pro3dwe1"
fi

if [ "$ba_default_download" = "" ]; then
  ba_default_download=" svn co https://hpc-forge.cineca.it/svn/CmakeBuilds/CmakeBuilds \$BA_PKG_SOURCE_DIR"
fi
if [ "$ba_test_mode" = "" ]; then
   test  "$user" = "$ba_test_user"
   if [ $? -eq 0 ]; then
      ba_test_mode=true
   else
      ba_test_mode=false
      ba_build_local=true
   fi
fi

echo "ba_test_mode-${user}-${ba_test_user}- ---${ba_test_mode}---"
if [ "$ba_author" = "" ]; then
    ba_author=`finger -p $user | grep Name: | sed s/^.*Name:\ //`
fi

if [ "$ba_category" = "" ]; then
    ba_category="tool"
fi

if [ "$ba_compiler" = "" ]; then
    ba_compiler='gnu/4.1.2'
fi
if [ "$ba_req_modules" = "" ]; then
    ba_req_modules_flag=''
else
  ba_req_modules_flag=""
  for mod in $ba_req_modules; do
     echo "adding requirement of module --->${mod}<---"
     ba_req_modules_flag="$ba_req_modules_flag --required-modules $mod"
  done
fi
  
if [ "$autopackage_name" = "" ]; then 
  autopackage_name=$ba_module_name
fi 

if [ "$autopackage_version" = "" ]; then 
  autopackage_version=$ba_module_version
fi 

if [ "$module_build_setup" = "" ]; then 
  module_build_setup="module purge\\nmodule load autoload cmake"
fi 


echo "author-->${ba_author}"
echo "category-->${ba_category}"
echo "compiler-->${ba_compiler}"
 configfile=`\
   ba create -f general.name=$ba_module_name \
	$ba_req_modules_flag \
	build.module.modulefile_schema=single \
 	build.minor_release_support=False general.version=$ba_module_version \
 	build.author="$ba_author"  general.category="$ba_category" \
 	build.configure.compiler_module="$ba_compiler" | \
   grep "Config file '" | sed s/^[^\']*\'// | sed  s/\'.*$// \
  `
echo "configfile-->${configfile}"
ba_prefix_dir=`ba query -i $configfile build.configure.prefix_dir | sed s/^[^=]*=//`
echo "prefix_dir-->${ba_prefix_dir}"

ba_build_dir=`ba query -i $configfile _INTERNAL_.build_dir | sed s/^[^=]*=//`
echo "build_dir-->${ba_build_dir}"
ba_work_dir=`ba query -i $configfile _INTERNAL_.work_dir | sed s/^[^=]*=//`
echo "work_dir-->${ba_work_dir}"

ba_module_dir=`ba query -i $configfile _INTERNAL_.module_dir | sed s/^[^=]*=//`
ba_module_file=`ba query -i $configfile _INTERNAL_.module_file | sed s/^[^=]*=//`
echo "modulefile-->${ba_module_dir}/${ba_module_file}"

if [ "$source_dir" = "" ]; then
  if  $ba_test_mode ; then
    source_dir=`dirname ${SCRIPT_PATH}`
    echo "external source dir --->${source_dir}<----"
  else
    source_dir="${ba_work_dir}/src"
  fi
fi
mkdir -p $source_dir

if [ "$work_default_base_dir" = "" ]; then
  work_default_base_dir="/scratch_local/${user}/build/ba_builds"
fi
if [ "$work_dir" = "" ]; then
  work_dir="${work_default_base_dir}/${ba_module_name}/${ba_module_version}"
  if  $ba_test_mode ; then
    mkdir -p $work_dir
  else
    if $ba_build_local ; then
      mkdir -p $work_dir
      ln -s $work_dir ${ba_work_dir}/build
      work_dir="${ba_work_dir}/build"
    else
      work_dir="${ba_work_dir}/build"
      mkdir -p $work_dir
    fi
  fi
fi

if  ${ba_test_mode} ; then
  echo "skipping source download"
  cd $source_dir
  current_revision=`svnversion`
  echo "current revision -->${current_revision}<--"
  build_source="cd \$BA_PKG_SOURCE_DIR\\n bzr revno > $work_dir/REVISION.txt"
else
  build_source="${ba_default_download}\\ncd \$BA_PKG_SOURCE_DIR\\n svnversion > $ba_work_dir/REVISION.txt"
  echo "------------sono qui------->${build_source}<--"

fi

if [ "$autopackage_assembly" = "" ]; then
  configure_command="cmake \${BA_PKG_SOURCE_DIR}/Assemblies/auto_package ${autopackage_config_args} -DAUTO_PACKAGE:STRING=${autopackage_name} -DAUTO_PACKAGE_VERSION:STRING=${autopackage_version} -DEXTERNAL_ASSEMBLY_COMMON_PREFIX:PATH=${ba_prefix_dir}"
else
  configure_command="cmake \${BA_PKG_SOURCE_DIR}/Assemblies/${autopackage_assembly} ${autopackage_config_args}  -DEXTERNAL_ASSEMBLY_COMMON_PREFIX:PATH=${ba_prefix_dir}"
fi

if [ "$make_command" = "" ]; then
  make_command="make -j 8"
fi

if [ "$make_command" = "" ]; then
  make_command="make -j 8"
fi


force_install_command="cd $work_dir\\nrm bld/${autopackage_name}/${autopackage_name}-prefix/src/${autopackage_name}-stamp/${autopackage_name}-install\\nmake ${autopackage_name}-install"

ba_hook_set_source='^BA_PKG_SOURCE_DIR=.*$'
ba_hook_prepare_source='DOWNLOAD_URL=""'
ba_hook_configure='# ./configure --prefix="$BA_PKG_INSTALL_DIR"'
ba_hook_make='# make$'
ba_hook_install='# make install$'


####################################  remove #########################################################
#build_source="bzr branch http://rvn05.plx.cineca.it:12000/files/virtualrome/bazaar_repo/CmakeDeps/lib/ \$BA_PKG_SOURCE_DIR\\ncd \$BA_PKG_SOURCE_DIR\\n bzr revno > $work_dir/REVISION.txt"
#build_source='bzr branch http://rvn05.plx.cineca.it:12000/files/virtualrome/bazaar_repo/CmakeDeps/lib/ $BA_PKG_SOURCE_DIR'

#build_source="${ba_default_download}\\ncd \$BA_PKG_SOURCE_DIR\\n bzr revno > $work_dir/REVISION.txt"


# sed "s@${ba_hook_prepare_source}@BA_PKG_SOURCE_DIR=${source_folder}\\n${build_source}\\n@" BUILD_SCRIPT | \
# sed "s@${ba_hook_configure}@cd $work_dir\\ncmake \${BA_PKG_SOURCE_DIR}/Assemblies/cmake\\n@" |
# sed "s@${ba_hook_make}@cd $work_dir\\nmake -j 8\\n@" |more
####################################  remove #########################################################

# sed --in-place=.orig\
# 	-e "s@${ba_hook_set_source}@BA_PKG_SOURCE_DIR=${source_dir}@" \
# 	-e "s@${ba_hook_prepare_source}@${build_source}\\n@" \
# 	-e "s@${ba_hook_configure}@cd $work_dir\\ncmake \${BA_PKG_SOURCE_DIR}/Assemblies/cmake -DEXTERNAL_ASSEMBLY_COMMON_PREFIX:PATH=${ba_prefix_dir}\\n@" \
#         -e "s@${ba_hook_make}@cd $work_dir\\nmake -j 8\\n@" \
# 	-e "s@^  # module@module@" \
# ${ba_build_dir}/BUILD_SCRIPT 

#configuring  build script 
sed --in-place=.orig\
	-e "s@${ba_hook_set_source}@BA_PKG_SOURCE_DIR=${source_dir}@" \
	-e "s@${ba_hook_prepare_source}@${build_source}\\n@" \
	-e "s@${ba_hook_configure}@cd $work_dir\\n${configure_command}\\n@" \
        -e "s@${ba_hook_make}@cd $work_dir\\n${make_command}\\n@" \
	-e "s@${ba_hook_install}@${force_install_command}@" \
	-e "s@^  # module purge@${module_build_setup}@" \
	-e "s@^  # module@module@" \
${ba_build_dir}/BUILD_SCRIPT 

#using build script for downloading
${ba_build_dir}/BUILD_SCRIPT -d
#using build script for configuring
${ba_build_dir}/BUILD_SCRIPT -C
#using build script for building
${ba_build_dir}/BUILD_SCRIPT -b
#using build script for install
${ba_build_dir}/BUILD_SCRIPT -i

if [ "$ba_download_url" = "" ]; then
  echo "try to find url from file -->${source_dir}/Packages/${autopackage_name}/${autopackage_version}/CMakeLists.txt"
  ba_download_url=`grep 'URL ' ${source_dir}/Packages/${autopackage_name}/${autopackage_version}/CMakeLists.txt | sed -e 's/^\s*URL //' -e 's/.$//'`
  echo "setting download url to -->${ba_download_url}"
fi

 ba postprocess -i $configfile -f general.description.homepage_url="${ba_home_url}" general.description.download_url="${ba_download_url}" general.description.short="${ba_short_desc}" general.description.long="${ba_long_desc}" general.license.license_type="${ba_license}"

sed --in-place=.orig\
	-e "s@# ba_modules_prereq@ba_modules_prereq@" \
	-e "s@# prepend-path@prepend-path@" \
	-e "s@# setenv@setenv@" \
	-e "s@# conflict @conflict @" \
${ba_build_dir}/MODULEFILE

ba module -f -i $configfile
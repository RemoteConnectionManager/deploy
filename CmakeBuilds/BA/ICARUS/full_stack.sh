export module_chain_suffix='MPI_MULTITHREAD'
export openmpi_module='openmpi/1.4.3--gnu--4.1.2'
export work_default_base_dir="/scratch_local/pro3dwe1/build/ba_builds/${module_chain_suffix}"

SCRIPT_PATH="${BASH_SOURCE[0]}";
if([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}";
if([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null


#${SCRIPT_PATH}/../H5FDdsm/0.9.7.sh
#${SCRIPT_PATH}/../ParaView/3.10.1_icarus.sh
${SCRIPT_PATH}/../ICARUS/icarus_plugin.sh

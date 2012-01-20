export ba_compiler='gnu/4.5.2'
export module_suffix='--gnu--4.5.2'
export openmpi_module='openmpi/1.4.3--gnu--4.5.2--gnu--4.1.2'
#export ba_test_mode=false

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

#${SCRIPT_PATH}/../Python/2.7.1.sh
#${SCRIPT_PATH}/../Qt4/4.7.2_shared.sh
${SCRIPT_PATH}/../ParaView/3.10.1_qtshared.sh
#http://activemq.apache.org/
PackageSetup()

set(Package_source_setup
	URL http://www.apache.org/dist//activemq/apache-activemq/5.5.0/apache-activemq-5.5.0-bin.tar.gz
	URL_MD5 81538848601793209099df5eef449d3c
)
PackageBinaryAdd()
# PackageBinarySimpleAdd(http://fpdownload.adobe.com/pub/flex/sdk/builds/flex3/flex_sdk_3.5.0.12683_mpl.zip ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/bin_download)
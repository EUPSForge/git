# EupsPkg config file. Sourced by 'eupspkg'

# Make sure the curl libraries that corresponds to curl binary
# are picked up. This is needed both by build() and install()
export CURLDIR=$(curl-config --prefix)

#
# Hack around a problem where the user may have curl on $PATH that is linked
# against a dynamic library that is not on LD_LIBRARY_PATH.  While libcurl
# itself will get picked up because of the -L....  option, the libraries
# that libcurl is linked against (e.g., libssl), won't, thus leading either
# to a failed build, or a failure to detect curl (and thus the lack of
# http/https support).  This happens with Anaconda (which distributes its
# own curl).
#
# We try to detect and work around this by looking at whether there's a -L
# stanza in curl-config --libs, and specifying an explicit LD_RUN_PATH if
# there is one.
#
LIBFLAGS=$(curl-config --libs)
if [[ $LIBFLAGS == -L* ]]; then
	lf=${LIBFLAGS#-L}
        lf=${lf%% *}
	export LD_RUN_PATH="$lf:$LD_RUN_PATH"
	echo "$LD_RUN_PATH"
fi

build()
{
	export NO_FINK=1
	export NO_DARWIN_PORTS=1

	default_build
}

install()
{
	default_install

	# Install the man pages
	PKGDIR="$PWD"
	cd "$PREFIX/share/man"
	tar xzf "$PKGDIR"/upstream/manpages/git-manpages-*.tar.gz
}

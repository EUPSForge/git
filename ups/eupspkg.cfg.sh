# EupsPkg config file. Sourced by 'eupspkg'

# Make sure the curl libraries that corresponds to curl binary
# are picked up. This is needed both by build() and install()
export CURLDIR=$(curl-config --prefix)

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

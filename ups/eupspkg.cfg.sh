# EupsPkg config file. Sourced by 'eupspkg'

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

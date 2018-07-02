# Add the following function to your .bashrc
chrsh() {
	# Usage:
	# chrsh       - drops into a bash shell inside the chroot environment
	# chrsh <cmd> - executes cmd inside chroot environment and returns
        subcmd=""
        if [ $# -gt 0 ]; then
                subcmd="-c \"$@\""
        fi
	# to spawn in a particular working directory add
	# --config-opts=nspawn_args="--chdir=/"
	# --config-opts=nspawn_args="--chdir=/path/to/dir"
	# two config-opts args are required to make an array, last dir is used
	# alternatively make the change in the chromium.cfg file
        mock -r chromium --unpriv shell "/bin/bash -l $subcmd" 2>/dev/null;
}

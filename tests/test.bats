setup() {
    set -eu -o pipefail
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
    export PROJNAME=test-craft-site
    export TESTDIR=$DIR/tests/$PROJNAME
    export DDEV_NON_INTERACTIVE=true

    ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true

    [ ! -d "$TESTDIR" ] && mkdir -p $TESTDIR

    rsync -ah --delete --exclude={"/.git/","/.github/","/tests/","/cms/vendor/"} $DIR $TESTDIR
}

# teardown() {
#   set -eu -o pipefail
#   cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
#   ddev stop ${PROJNAME} -O
#   # [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
# }

@test "run [ddev-setup.sh] install script " {
    # skip
    cd ${TESTDIR}
    run ./bin/ddev-setup.sh -a
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Creating [test-craft-site] DDEV project" ]
    [ "${lines[1]}" = "Generating creating DDEV config.yaml file" ]
    [ "${lines[2]}" = "Renaming ./cms/composer.ddev-installer.json to ./cms/composer.json" ]
    [ "${lines[3]}" = "Starting DDEV" ]
    [ "${lines[5]}" = "Installing Craft" ]
}

@test "check if [ddev craft] command is available" {
    skip
    cd ${TESTDIR}
    run ddev craft --help
    [ "${lines[0]}" = "Run craft commands inside the web container ./cms (shell web container command)" ]
}

@test "check if craft is installed" {
    skip
    cd ${TESTDIR}
    run ddev craft install/check
    [ "$output" = "Craft is installed." ]
}
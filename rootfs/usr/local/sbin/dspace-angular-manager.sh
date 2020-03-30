#!/bin/bash
set -e

source utils.sh

# Init script environment
init_env () {
	export DSPACE_DIR=/app/dspace-angular

	CFG_FILENAME="$DSPACE_DIR/config/environment.default.js"
	

}

init_env
#reset_permissions
install () {
   cd /app
   git clone --branch "${DSPACE_ANGULAR_GIT_REVISION}" "${DSPACE_ANGULAR_GIT_URL}"
   cd dspace-angular
   yarn install --network-timeout 300000
}

start () {
	if [ ! -d $DSPACE_DIR ]; then
		print_err  "El directorio de instalación ${DSPACE_DIR} no existe, debe instalar!"
	fi
   cd /app/dspace-angular
   yarn start

}

usage() {
	#TODO UPDATE MSG
	echo "     - start"
	echo "     - install"
	exit 1
}

case "$1" in
  	start)
        if [ "$2" = "--debug" ]; then
           start "--debug"
        else
           start
        fi
		just_wait
		;;
  	install)
		install
		;;
  	*)
        usage
        ;;
esac
exit 0

just_wait() 
{
	# tail -n 10 ${DSPACE_DIR}/log/dspace.log
}


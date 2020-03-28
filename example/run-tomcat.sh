#!/bin/bash

set -e -u -o pipefail

declare -r SCRIPT_DIR=$(cd -P $(dirname $0) && pwd)

valid_command() {
  local fn=$1; shift
  [[ $(type -t "$fn") == "function" ]]
}

command.start() {
    cd /opt/webserver
    if [[ ! -h webapps.old ]]; then
        mv webapps webapps.old
        ln -s /workspaces/spring-framework-petclinic/target webapps
    fi
    bin/catalina.sh run
}

command.uninstall() {
    cd /opt/webserver
    if [[ -h webapps.old ]]; then
        rm webapps
        mv webapps.old webapps
    fi
}

command.help() {
  cat <<-EOF

  Usage:
      run-tomcat.sh [command] [options]
  
  Example:
      run-tomcat.sh start 
  
  COMMANDS:
      start                          Starts tomcat instance (setting up link to target 
                                     directory as necessary) in foreground
      uninstall                      Restores tomcat instance to default
      help                           Help about this command

  OPTIONS:
      <none>
EOF
}

main() {
  local fn="command.$COMMAND"
  valid_command "$fn" || {
    echo "invalid command '$COMMAND'"
    exit 1
  }

  cd $SCRIPT_DIR
  $fn
  return $?
}

while (($#)); do
    case "$1" in
        start|uninstall|help)
            COMMAND="$1"
            shift 1
            ;;
        -*|--*)
            echo "unknown option."
            exit 1
            ;;
        *)
            echo "unknown option"
            exit 1
            ;;
    esac
done

main
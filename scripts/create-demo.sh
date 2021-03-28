#!/bin/bash

set -Eeuo pipefail

declare -r SCRIPT_DIR=$(cd -P $(dirname $0) && pwd)
declare PROJECT_PREFIX="tssc-demo"
declare -r ANSIBLE_DEMO_PLAYBOOK_DIR="${SCRIPT_DIR}/../ansible"
declare ANSIBLE_ACTION="create"

display_usage() {
cat << EOF
$0: Create CDC Monolith Demo --

  Usage: ${0##*/} [ OPTIONS ]
  
    -p <TEXT>  [optional] Project prefix to use.  Defaults to "tssc-demo"
    -v         [optional] Run ansible playbooks in verbose mode
    -i         [optional] Install pre-requisites

EOF
}

get_and_validate_options() {
  # Transform long options to short ones
#   for arg in "$@"; do
#     shift
#     case "$arg" in
#       "--long-x") set -- "$@" "-x" ;;
#       "--long-y") set -- "$@" "-y" ;;
#       *)        set -- "$@" "$arg"
#     esac
#   done

  
  # parse options
  while getopts ':vip:h' option; do
      case "${option}" in
          p  ) p_flag=true; PROJECT_PREFIX="${OPTARG}";;
          v  ) ANSIBLE_VERBOSE="-vvvvv";;
          i  ) ANSIBLE_INSTALL_PRE="-e install_prereq=true";;
          h  ) display_usage; exit;;
          \? ) printf "%s\n\n" "  Invalid option: -${OPTARG}" >&2; display_usage >&2; exit 1;;
          :  ) printf "%s\n\n%s\n\n\n" "  Option -${OPTARG} requires an argument." >&2; display_usage >&2; exit 1;;
      esac
  done
  shift "$((OPTIND - 1))"

  if [[ -z "${PROJECT_PREFIX}" ]]; then
      printf '%s\n\n' 'ERROR - PROJECT_PREFIX must not be null' >&2
      display_usage >&2
      exit 1
  fi
}

main() {
    # import common functions
    . $SCRIPT_DIR/common-func.sh

    trap 'error' ERR
    trap 'cleanup' EXIT SIGTERM
    trap 'interrupt' SIGINT

    get_and_validate_options "$@"

    # Run the ansible playbook (see inventory file for additional variables that can be overriden with -e)
    echo "Attempting to run the ansible playbook for demo"
    ansible-playbook -i ${ANSIBLE_DEMO_PLAYBOOK_DIR}/inventory ${ANSIBLE_DEMO_PLAYBOOK_DIR}/main.yaml \
      -e "ACTION=${ANSIBLE_ACTION}" \
      $(echo ${ANSIBLE_VERBOSE:-""}) $(echo "${ANSIBLE_INSTALL_PRE:-""""}")

    echo "Demo installation completed without error."
}

main "$@"
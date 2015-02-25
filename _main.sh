#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

is_verbose="false"
is_debug="false"
is_help="false"
pflag=""
tflag=""

while getopts "tp:hvd" flag; do
  case "${flag}" in
    p) pflag="${OPTARG}" ;;
    t) tflag="${OPTARG}" ;;
    h) is_help="true" ;;
    d) is_debug="true" ;;
    v) is_verbose="true" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

source "${DIR}/_ui.sh"
source "${DIR}/_functions.sh"

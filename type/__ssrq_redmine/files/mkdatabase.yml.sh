#!/bin/sh -e

in_list() (
	needle=${1:?}
	shift
	for x
	do
		# shellcheck disable=SC2015
		test "${x}" = "${needle}" && return 0 || continue
	done
	return 1
)

yaml_quote() { printf '%s\n' "$*" | sed "s/'/''/g;1s/^/'/;\$s/\$/'/"; }

param_missing() {
	printf 'Parameter --%s is required but not specified.\n' "${1:?}" >&2
	params_ok=false
}

# param	var_name	req?	compatible RDBMS
PARAM_MAP="\
db-name	db_name	opt	mysql postgresql sqlserver sqlite
db-host	db_host	opt	mysql postgresql
db-port	db_port	opt	mysql
db-user	db_user	req	mysql postgresql sqlserver
db-schema	db_schema	opt	postgresql
"


env_name='production'

read -r db_type <"${__object:?}/parameter/db-type"

while IFS='	' read -r param_name var_name req rdbms_compat
do
	test -n "${param_name}" || continue

	# shellcheck disable=SC2086
	if in_list "${db_type:?}" ${rdbms_compat-}
	then
		if test -s "${__object:?}/parameter/${param_name:?}"
		then
			read -r "${var_name:?}" <"${__object:?}/parameter/${param_name:?}"
		elif test "${req}" = 'req'
		then
			param_missing "${param_name}"
		fi
	elif test -f "${__object:?}/parameter/${param_name:?}"
	then
		printf 'Parameter --%s is incompatible with %s\n' "${param_name}" "${db_type}" >&2
		params_ok=false
	fi
done <<EOF
${PARAM_MAP:?}
EOF
${params_ok:-true} || exit 2

if test "${db_type}" != 'sqlite'
then
	# special case: all RDBMS except SQLite have a password
	db_passfile="${__object:?}/parameter/db-password"
fi


case ${db_type-}
in
	(mysql)
		cat <<-EOF
		${env_name}:
		  adapter: mysql2
		  database: $(yaml_quote "${db_name:-redmine}")
		  host: $(yaml_quote "${db_host:-localhost}")
		  port: $((${db_port:-3306}))
		  username: $(yaml_quote "${db_user:?}")
		  password: |-
		$(sed -e 's/^/    /' "${db_passfile:?}")
		EOF
		;;
	(postgresql)
		cat <<-EOF
		${env_name}:
		  adapter: postgresql
		  database: $(yaml_quote "${db_name:-redmine}")
		  host: $(yaml_quote "${db_host:-localhost}")
		  username: $(yaml_quote "${db_user:?}")
		  password: |-
		$(sed -e 's/^/    /' "${db_passfile:?}")
		  encoding: utf8
		  schema_search_path: $(yaml_quote "${db_schema:-public}")
		EOF
		;;
	(sqlite)
		cat <<-EOF
		${env_name}:
		  adapter: sqlite3
		  database: $(yaml_quote "${db_name:-db/redmine.sqlite3}")
		EOF
		;;
	(sqlserver)
		cat <<-EOF
		${env_name}:
		  adapter: sqlserver
		  database: $(yaml_quote "${db_name:-redmine}")
		  username: $(yaml_quote "${db_user:?}")
		  password: |-
		$(sed -e 's/^/    /' "${db_passfile:?}")
		EOF
		;;
	(*)
		printf 'Invalid --db-type: %s\n' "${db_type}" >&2
		exit 1
		;;
esac

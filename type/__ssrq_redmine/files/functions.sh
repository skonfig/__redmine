#!/bin/sh -e
#
# 2022 Dennis Camera (dennis.camera at ssrq-sds-fds.ch)
#
# This file is part of cdist.
#
# cdist is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cdist is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cdist. If not, see <http://www.gnu.org/licenses/>.
#

version_ge() {
	# usage: version_ge version_is min_version_expected
	#
	# compares two version numbers (up to three numeric components separated
	# with dots)
	# returns 0 if `version_is` >= `min_version_expected`, 1 otherwise.
	#
	# NOTES: if the lowest value (1st line) of the two version numbers is equal
	#        to `min_version_expected`, `version_is` must be the same or larger.
	#        explicit `-k n,n` is required for some sort(1)s.
	printf '%s\n' "$1" "$2" \
	| sort -t '.' -n -k 1,1 -k 2,2 -k 3,3 \
	| head -1 \
	| grep -qxF "$2"
}

quote() { printf '%s\n' "$*" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"; }

yaml_quote() { printf '%s\n' "$*" | sed "s/'/''/g;1s/^/'/;\$s/\$/'/"; }

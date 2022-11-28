#!/bin/zsh

# Colors:
NC='\033[0m' # No Color
RED='\033[1;31m';
YELLOW='\033[1;33m';
GREEN='\033[1;32m';
BLUE='\033[1;34m';

repo_location=./
if [ ! -f "$repo_location/Makefile" ]; then
	repo_location=../
fi

local_location=42Tester-push_swap/
if [ ! -f "$local_location/tester_performance.sh" ]; then
	local_location=./
fi


if [ ! -f "$repo_location/Makefile" ]; then
	echo "${RED}ERROR${NC}: Not able to set repo location"
elif [ ! -f "$local_location/tester_performance.sh" ]; then
	echo "${RED}ERROR${NC}: Not able to set local location"
	return;
fi


pushswap=${repo_location}pushswap
checker=${repo_location}checker

make -C ${repo_location} bonus
if [ ! -f ${checker} ]; then
	echo "${RED}ERROR${NC}: Not able to compile bonus"
	return;
fi

is_ok() {
	if [ "$1" = "OK" ] && [ "$2" = "" ]; then
		echo "1"
	else
		echo "0"
	fi
}

is_ko() {
	if [ "$1" = "" ] && [ $(echo "$2" | grep 'KO')  ]; then
		echo "1"
	else
		echo "0"
	fi
}

tester_file() {
	name="$1"
	file="$2"
	ft=$3

	echo
	echo
	echo "${BLUE}*********** ${name} ***********${NC}"

	while IFS= read -r t; do
		name=$(echo "$t\c" | cut -d: -f1);
		steps=$(echo "$t\c" | cut -d: -f2 | sed 's/,/\n/g');
		input=$(echo "$t\c" | cut -d: -f3);
		
		fail="false";

		echo
		echo "${name} \c"
		# echo -n "${steps}" | ${checker} $input > result.tmp 2> error.tmp;
		eval "echo -n \"${steps}\" | ${checker} $input > result.tmp 2> error.tmp"
		result=$(cat result.tmp);
		error=$(cat error.tmp);
		rm result.tmp error.tmp;

		if [ $($ft "$result" "$error") = "1" ]; then
			echo "${GREEN}[OK]${NC}";
		else
			echo "${RED}[KO]${NC}";
			fail="true";
		fi

		if [ "$fail" = "true" ]; then
			echo "${BLUE}  Steps:${NC}";
			echo "    ${BLUE}$>${NC} echo -n \"$steps\" | ${checker} $input";

			echo "${YELLOW}  result:${NC} '$result'"
			echo "${YELLOW}  error:${NC}\n'$error'"
		fi
	done < $file
}

tester_file "valid" "${local_location}.test/bonus/valid" "is_ok"
tester_file "invalid" "${local_location}.test/bonus/invalid" "is_ko"

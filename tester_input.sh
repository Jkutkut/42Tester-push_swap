#!/bin/sh

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

local_location="42Tester-push_swap/"
if [ ! -f "$local_location/tester_performance.sh" ]; then
	local_location="./"
fi


if [ ! -f "$repo_location/Makefile" ]; then
echo "${RED}ERROR${NC}: Not able to set repo location"
elif [ ! -f "${local_location}tester_performance.sh" ]; then
	echo "${RED}ERROR${NC}: Not able to set local location"
	return;
fi

executable=${repo_location}push_swap

run_test() {
	echo "- ${BLUE}$1${NC} \c"
	eval "$executable $2" > result.tmp 2> output.tmp
	if [ ! "$(cat output.tmp)" = "" ]; then
		echo "${RED}[FAIL]${NC}"
		echo "  $executable $2"
		cat output.tmp
		echo
		return;
	else
		echo "${GREEN}[HANDLE_OK]${NC} \c"
	fi

	if [ ! -f $checker ]; then
		echo "${YELLOW}[NOT CHECKED]${NC}"
	else
		r=$(cat result.tmp | $checker $2 2> /dev/null)
		if [ "$r" = "OK" ] || [ "$r" = "" ]; then
			echo "${GREEN}[OK]${NC}"
		else
			echo "${RED}[KO]${NC}"
			echo "  $executable $2"
			echo "  $executable $2 | $checker $2"
		fi
	fi
	rm result.tmp output.tmp
}

run_invalid_test() {
	echo "- ${BLUE}$1${NC} \c"
	eval "$executable $2" > result.tmp 2> output.tmp
	if [ ! "$(cat output.tmp)" = "" ] && [ "$(cat result.tmp)" = "" ]; then
		echo "${GREEN}[HANDLE_OK]${NC}"
	else
		echo "${RED}[FAIL]${NC}"
		echo "  $executable $2"
	fi
	rm result.tmp output.tmp
}


make -C $repo_location

checker=${repo_location}checker
if [ ! -f $checker ]; then
	checker=${local_location}checker
fi

echo "${BLUE}
  _____                 _ _     _ 
 |_   _|               | (_)   | |
   | |  _ ____   ____ _| |_  __| |
   | | | '_ \ \ / / _' | | |/ _' |
  _| |_| | | \ V / (_| | | | (_| |
 |_____|_| |_|\_/ \__,_|_|_|\__,_|
${NC}"

input_file=$local_location.test/invalid_input
while IFS= read -r line; do
	test_name=$(echo $line | cut -d: -f1)
	input=$(echo $line | cut -d: -f2)
	run_invalid_test "$test_name" "$input"
done < "$input_file"


echo "${BLUE}
 __      __   _ _     _ 
 \ \    / /  | (_)   | |
  \ \  / /_ _| |_  __| |
   \ \/ / _' | | |/ _' |
    \  / (_| | | | (_| |
     \/ \__,_|_|_|\__,_|
${NC}"

input_file=$local_location.test/valid_input
while IFS= read -r line; do
	test_name=$(echo $line | cut -d: -f1)
	input=$(echo $line | cut -d: -f2)
	run_test "$test_name" "$input"
done < "$input_file"


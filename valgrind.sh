#!/bin/sh

# Constants
min=0
max=100

# Check directory of execution
repo_location=./
if [ ! -f "$repo_location/Makefile" ]; then
	repo_location=../
fi

if [ ! -f "$repo_location/Makefile" ]; then
	echo "${RED}ERROR${NC}: Not able to set repo location"
fi

# Handle arguments
if [ "$#" -gt 0 ]; then
	input="$@"
else
	input=$(ruby -e "puts ($min..$max).to_a.shuffle.join(' ')")
fi

make -C ${repo_location}


echo "${repo_location}push_swap $input"
echo "----------------";

# valgrind --leak-check=full \
#          --show-leak-kinds=all \
#          --track-origins=yes \
#          --verbose \
#          --log-file=valgrind-out.txt \
#          ./executable exampleParam1

valgrind --leak-check=full \
         --show-leak-kinds=all \
         --track-origins=yes \
         ${repo_location}push_swap $input > /dev/null &&
{
	echo "----------------";
	echo
	echo "It worked!"
} ||
{
	echo "----------------";
	echo
	echo "It failed!"
}


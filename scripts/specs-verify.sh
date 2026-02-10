#!/bin/bash

EXIT_CODE=0

npx cucumber-js -p Docs \
                > /dev/null
if [ $? -ne 0 ]; then EXIT_CODE=1; fi

npx cucumber-js -p DocsIntegratie \
                > /dev/null
if [ $? -ne 0 ]; then EXIT_CODE=1; fi

npx cucumber-js -p AbonnementenService \
                > /dev/null
if [ $? -ne 0 ]; then EXIT_CODE=1; fi

npx cucumber-js -p EndToEnd \
                > /dev/null
if [ $? -ne 0 ]; then EXIT_CODE=1; fi

# Exit with error code if any command failed
exit $EXIT_CODE

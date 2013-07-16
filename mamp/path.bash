
if [[ ! -d /Applications/MAMP/bin/php/ ]]; then
	return
fi

# change here for the 5.x version you want
phpMajorVersion="5.3"

# detect the php minor version based on major version
phpMinorVersion=$(ls /Applications/MAMP/bin/php/ | grep "$phpMajorVersion" | awk -F. '{print $NF}')
phpVersion="$phpMajorVersion.$phpMinorVersion"

# MAMP mysql
PATH=/Applications/MAMP/Library/bin:$PATH
# MAMP pear, php, phpunit, etc. of version php 5.x (defined above)
PATH=/Applications/MAMP/bin/php/php$phpVersion/bin:$PATH

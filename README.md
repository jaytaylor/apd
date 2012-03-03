Author: Jay Taylor [@jtaylor]
Date: 2012-03-02

## installation/compilation instructions ##
    `./apdBuilder.sh`
    `make install` or `sudo make install`
    then add the following lines to the appropriate php.ini file:

        `zend_extension = /usr/local/php/5.3.8/lib/php/extensions/no-debug-non-zts-20090626/apd.so`
        `apd.dumpdir = /tmp/trace`
        `apd.statement_tracing = 0`

## description ##
    this shell script helps build the current version of the
    Advanced PHP Debugger, a.k.a. "apd."  This script is based on the steps
    documented by jj5 at progclub.org:
    https://www.progclub.org/blog/2012/01/10/profiling-a-php-script/

## additional note ##
As of the time of authorship of this tool, the current stable version
of apd is 1.0.1 (since 2004-09-28.)


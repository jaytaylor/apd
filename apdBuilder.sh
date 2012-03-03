#!/usr/bin/env bash

##
# @author Jay Taylor [@jtaylor]
# @date 2012-03-02
#
# @description this shell script helps build the current version of the
# Advanced PHP Debugger, a.k.a. "apd."  This script is based on the steps
# documented by jj5 at progclub.org:
# https://www.progclub.org/blog/2012/01/10/profiling-a-php-script/
#
# @note As of the time of authorship of this tool, the current stable version
# of apd is 1.0.1 (since 2004-09-28.)

cd "$(dirname $0)"

if [ -z "$(which phpize)" ]; then
    echo 'fatal: missing required binary: phpize' 1>&2
    exit 1
fi

if ! [ -d '/tmp/trace' ]; then
    mkdir /tmp/trace
fi

make clean

phpize

export TEST_PHP_EXECUTABLE=$(which php)

./configure

make

if [ -z "$(grep '^[ \t]*apd\.dumpdir' tmp-php.ini)" ]; then
    echo "zend_extension = $(pwd)/modules/apd.so" >> tmp-php.ini
    echo "apd.dumpdir = /tmp/trace" >> tmp-php.ini
    echo "apd.statement_tracing = 0" >> tmp-php.ini
fi


echo -e '--TEST--
Just testing.
--FILE--
<?php

apd_set_pprof_trace();

function a() { echo "a"; }
function b() { a(); echo "b"; }

a();
b();
a();
--EXPECT--
aaba' > test.phpt


# Clean up test dirs variable in test runner.
perl -p -i -e "s/(.test_dirs = array.)/\1'.'/" run-tests.php

php -n -c $(pwd)/tmp-php.ini -d open_basedir= -d output_buffering=0 -d memory_limit=-1 $(pwd)/run-tests.php -n -c $(pwd)/tmp-php.ini


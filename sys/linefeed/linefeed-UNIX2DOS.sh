#!/bin/bash

sed 's/$'"/`echo \\\r`/" $*

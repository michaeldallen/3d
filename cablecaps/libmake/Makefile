# BOF

SHELL := bash

.ONESHELL:







MAKEFILE_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

ifneq (,$(wildcard ${MAKEFILE_PATH}makelib.make))
default : make.targets
endif

ifneq (,$(wildcard ${MAKEFILE_PATH}makelib.*))
include ${MAKEFILE_PATH}makelib.*
endif



# EOF

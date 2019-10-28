export ASTIELECTRON_BUNDLER_EXECUTABLE := $(shell command -v astilectron-bundler  2> /dev/null)
export BIN_DIR := ./output


build_info: check_prereq ## Build the container
	@echo ''
	@echo '---------------------------------------------------------'
	@echo 'ASTIELECTRON_BUNDLER_EXECUTABLE "$(ASTIELECTRON_BUNDLER_EXECUTABLE)"'
	@echo '---------------------------------------------------------'
	@echo ''


####################################################################################################################
##
## help for each task - https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
##
####################################################################################################################
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help



####################################################################################################################
##
## Build of binaries
##
####################################################################################################################

binaries: demo ## build binaries in bin dir

create_dir:
	@mkdir -p $(BIN_DIR)


check_prereq: create_dir
ifndef ASTIELECTRON_BUNDLER_EXECUTABLE
	go install github.com/asticode/go-astilectron-bundler/astilectron-bundler
endif
	$(warning "found go-astilectron-bundler")


fmt: ## run fmt
	go fmt github.com/asticode/go-astilectron-demo/...


demo: build_info ## build demo binary in bin dir
	@echo "build demo"
	@rm -f ./bind.go
	astilectron-bundler -v cc
	@echo ''
	@echo ''



####################################################################################################################
##
## Cleanup of binaries
##
####################################################################################################################

clean: ## clean demo
	@rm -rf $(BIN_DIR)

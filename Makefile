#!/usr/bin/env make -rRf

ERL      	?= erl +A 4 +K true
APP      	:= pm
REL_APP  	:= pm
REBAR    	?= rebar
DIALYZER 	?= dialyzer
MKDIR 		?= mkdir
RM    		?= rm
MV    		?= mv
CP    		?= cp
CD    		?= cd
SHELL 		?= sh
INCLUDE_DIR := include
SRC_DIR     := src
ERL_LIBS	:= apps:deps:plugins

APPS   := $(a)
SUITES := $(s)

.SILENT: init_rel

.PHONY: deps

all: deps
	@$(REBAR) compile

init_rel: all
	@$(RM) -R rel
	@$(MKDIR) rel
	@$(CD) rel && $(REBAR) create-node nodeid=$(APPS)

rel: all
	@$(RM) -rf rel/$(REL_APP)
	@$(REBAR) generate
	@cp -fi ./sys/hooks/empty.so `find ./apps -name "*.so"` rel/$(REL_APP)/ports/

deps: vsn
	@$(REBAR) get-deps	

clean:
	@$(REBAR) clean

distclean: clean
	@$(REBAR) delete-deps

docs:
	@$(ERL) -noshell -run edoc_run application '$(APP)' '"."' '[]'

vsn:
	@$(SHELL) sys/tools/update.sh $(APP)

# e.x: 
#   make test                      :: Test release
#	make test s=simple_test        :: Test module in all applications
#	make test a=edht s=simple_test :: Test module in one application
#	make test a=edht               :: Test one application
test:		
	@$(REBAR) eunit apps=$(a) suite=$(s) skip_deps=true	

dialyze:
	@dialyzer -n -I $(INCLUDE_DIR) --src $(SRC_DIR)/*.erl

# make run master || make run slave
run:
	@sh ./rel/$(REL_APP)/bin/$(REL_APP) console $(filter-out $@, $(MAKECMDGOALS))
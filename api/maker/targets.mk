update:
	@git submodule update --init --recursive&& cd api && git submodule update && git checkout master && git pull && echo "please commit your update"
ifdef MID
MYCURL:=$(shell echo curl -o /dev/null -w \"Code: %{response_code} size: %{size_upload} %{url_effective}\" --progress-bar  --proxy socks5h://localhost:9876 -X POST)
else
MYCURL:=$(shell echo curl -o /dev/null -w \"Code: %{response_code} size: %{size_upload} %{url_effective}\" --progress-bar  -X POST)
endif

#preload marathon ip if needed
ifdef MID
IP:=$(shell curl -s --proxy socks5h://localhost:9876 http://marathon.mesos/marathon/v2/apps/$(MID)| jq -rc '(.app.tasks|.[0]|.host +":"+(.ports[0]|tostring))')
ifdef IP
$(info target $(MID) ip $(IP))
else
$(error failed to load marathon ip for $(MID), please expose socks5h://localhost:9876)
endif
endif

ifndef PERSIST
 PERSIST:=false
endif

#prepare variables
ifeq ($(MAKECMDGOALS),push)
TARGETHOST := $(if $(GATEWAY),http://$(GATEWAY):9900,$(if $(IP),http://$(IP),http://gateway:9900))
APIKey:=bf91c7df63da48d7ba18cacdd3909a64
else ifeq ($(MAKECMDGOALS),pushf)
APIKey:=bf91c7df63da48d7ba18cacdd3909a64
URL := $(if $(GATEWAY),http://$(GATEWAY):9900/api/beam/$(APIKey)?persist=false,$(if $(IP),http://$(IP)/api/beam/$(APIKey)?persist=false,$(if $(REMOTE_GERVER),https://$(REMOTE_GERVER)/api/private/pushRemoteCode?gatewayId=$(REMOTE_GATEWAY),http://gateway:9900/api/beam/$(APIKey)?persist=false)))
#URL :=$(TARGETHOST)/api/beam/$(APIKey)?persist=false
else ifeq ($(MAKECMDGOALS), pushremote)
TARGET_HOST=$(REMOTE_GERVER)
TARGET_GATEWAY=$(REMOTE_GATEWAY)
URL :=https://$(TARGET_HOST)/api/private/pushRemoteCode?gatewayId=$(TARGET_GATEWAY)
endif



ifdef APP
#push a single app found in the _rel dir
push : app
	$(info $(shell $(MYCURL) $(foreach file,$(wildcard $(dir $(shell find ebin -name $(APP).app))*),-F $(notdir $(file))=@$(file)) $(shell echo $(TARGETHOST)/api/$(APP)/$(APIKey))?persist=$(PERSIST) 2>&1))
else
#push all .apps found in the _rel dir
push : app
	$(info $(shell $(MYCURL) $(foreach file,$(wildcard $(dir $(shell find ebin -name *$(PROJECT).app))*),-F $(notdir $(file))=@$(file)) $(shell echo $(TARGETHOST)/api/$(PROJECT)/$(APIKey))?persist=$(PERSIST) 2>&1))
endif

#compile and push specified .erl file or folder
ifdef FILE
ifeq ($(suffix $(FILE)),.erl)
COMPILEPATH:=$(FILE)
else
COMPILEPATH:=$(FILE)/*.erl
endif

compilefile:
	@rm -rf pushebin;mkdir -p pushebin;erlc -I include -o pushebin $(COMPILEPATH)

ifdef REMOTE_SECRET
pushf: compilefile totp
	$(info Current TOTP is $(TOTP))
	$(info $(shell $(MYCURL) $(foreach ifile,$(wildcard pushebin/*),-F $(basename $(notdir $(ifile)))=@$(ifile)) \
		$(URL) -H"x-roc-otp-auth: $(TOTP)" 2>&1))
else
pushf: compilefile
	$(info $(shell $(MYCURL) $(foreach ifile,$(wildcard pushebin/*),-F $(basename $(notdir $(ifile)))=@$(ifile)) $(URL) 2>&1))
endif

else
pushf:
	$(info FILE not defined please specify like FILE=./src/sample.erl make pushf)
endif

totp:
	 $(TOTP:=$(shell api/maker/totp.sh $(cat $(REMOTE_SECRET)))

ifdef REMOTE_SECRET
pushremote: compilefile totp
	$(info Current TOTP is $(TOTP))
	$(info $(shell $(MYCURL) $(foreach ifile,$(wildcard pushebin/*),-F $(basename $(notdir $(ifile)))=@$(ifile)) \
		$(URL) -H"x-roc-otp-auth: $(TOTP)" 2>&1))
else
pushremote:
	$(error Remote secret is not defined)
endif

h: 
	$(info @ ROC-Connect core3 plugin build enviroment $(PROJECT_VERSION):)
	$(info )
	$(info @ You can transfer your development version using this commands:)
	$(info - GATEWAY=10.0.0.14 APP=nanny make push                     build and push apps if no APP is specified all local deps will be transfered GATEWAY/MID)
	$(info - GATEWAY=10.0.0.14 FILE=./src/sample.erl make pushf        dirty build file or folder! and push it GATEWAY/MID)
	$(info - REMOTE_GATEWAY=MAC_ADDRESS REMOTE_GERVER=gerver REMOTE_SECRET=./secret FILE=./src/sample.erl make pushremote		push to remote gateway on specific gerver)
	$(info - MID=alpha-smarthome/alpha-smarthome make push $$APPNAME    build and push APPNAME erlang files to marathon mesos app)
	$(info )
	$(info @ remote Observer, ensure local epmd is stopped and observer is started)
	$(info - ssh -L 4369:localhost:4369 -L 9001:localhost:9001 root@gateway)
	$(info - erl -name debug@127.0.0.1 -setcookie core3 -hidden -run observer)
	$(info - )
                                                                                                

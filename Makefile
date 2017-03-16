.PHONY: dep vendor upload provision

all: upload

BERKS=$(shell test -d /Applications && echo "/usr/local/bin/berks" || echo "/usr/bin/berks")

$(BERKS):
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

dep: $(BERKS)
	berks install

vendor: dep
	berks vendor

upload: vendor
	berks upload
	knife upload /

provision: upload
	@chef-client -c .chef/config.rb -l warn

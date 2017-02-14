.PHONY: dep vendor upload provision

all: upload

/usr/bin/berks:
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

dep: /usr/bin/berks
	berks install

vendor: dep
	berks vendor

upload: vendor
	berks upload
	knife upload /

provision: upload
	@chef-client -c .chef/config.rb -l warn

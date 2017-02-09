.PHONY: dep vendor upload provision

all: provision

dep:
	berks install

vendor: dep
	berks vendor

upload: vendor
	berks upload
	knife upload /

provision: upload
	@chef-client -c .chef/config.rb

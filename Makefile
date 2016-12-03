.PHONY: dep up vendor provision

all: provision

dep:
	berks install

up:
	berks update

vendor: dep
	berks vendor

upload: vendor
	berks upload
	knife upload /

provision: upload
	@chef-client -c .chef/config.rb

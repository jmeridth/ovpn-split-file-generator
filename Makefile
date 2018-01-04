DOCKER_COMPOSE := docker-compose

.PHONY : help
help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

.PHONY : all
all : validate dc cpy clean ## all the things

.PHONY : validate
validate : ## ensure client.ovpn file exists in current directory
	@rm -f client.split.ovpn
	test -f client.ovpn && echo "File client.ovpn does exist, proceeding..." || echo "File client.ovpn does not exist"

.PHONY : dc
dc : ## run docker-compose
	@docker-compose up

.PHONY : cpy
cpy : ## copy generated client.ovpn.split
	@docker cp ovpn-files-1:/tmp/client.split.ovpn .
	docker cp ovpn-files-1:/tmp/ca.crt .
	docker cp ovpn-files-1:/tmp/user.crt .
	docker cp ovpn-files-1:/tmp/client.key .
	docker cp ovpn-files-1:/tmp/ta.key .

.PHONY : clean
clean : ## copy generated client.ovpn.split
	@docker rm -f ovpn-files-1
	docker rmi openvpn_files

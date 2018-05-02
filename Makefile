DOCKER_COPY := docker cp ovpn-files-1:/tmp

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
	@/usr/local/bin/docker-compose up

.PHONY : cpy
cpy : ## copy generated client.ovpn.split
	@${DOCKER_COPY}/client.split.ovpn .
	${DOCKER_COPY}/ca.crt .
	${DOCKER_COPY}/user.crt .
	${DOCKER_COPY}/client.key .
	${DOCKER_COPY}/ta.key .

.PHONY : clean
clean : ## copy generated client.ovpn.split
	@docker rm -f ovpn-files-1
	docker rmi ovpnsplitfilegenerator_files

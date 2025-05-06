################################################################################################################################################################
--targets:
	@echo "Available Makefile targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
################################################################################################################################################################

show-version: ## current version
	@echo "version: `cat version.txt`"

config-local: ## configure local build
	./etc/local_config.sh

build-local: ## run local build
	./etc/local_build.sh

docker-build-image:
	./etc/local_docker_make_buildimage.sh

docker-build-image-macos:
	./etc/local_docker_make_buildimage_macos.sh

docker-bash:
	./etc/local_docker_bash.sh

KICK-GITHUB-TEST-BUILD: ## tags with test (and removes it right away) to test github builds
	git tag ci-build
	git push --tags
	git push --delete origin ci-build
	git tag --delete ci-build
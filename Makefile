
BUILD_DATE := $(shell date --utc +"%Y-%m-%dT%H:%M:%SZ")
NAME := alexandrecarlton/systemd
VCS_REF := $(shell git rev-parse --short HEAD)
VCS_URL := https://github.com/AlexandreCarlton/systemd-docker
# We create these volumes so that we may use systemd within this container.
# See:
#  - https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/systemd/systemd/Dockerfile
#  - https://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container/
DOCKER_CMD := docker run \
	--detach \
	--rm \
	--mount=type=bind,source=/sys/fs/cgroup,destination=/sys/fs/cgroup,readonly \
	--mount=type=tmpfs,tmpfs-size=512M,destination=/run \
	--mount=type=tmpfs,tmpfs-size=256M,destination=/tmp \
	$(NAME)
DOCKER_CMD_DEBUG := docker run \
	--interactive \
	--rm \
	--tty \
	--mount=type=bind,source=/sys/fs/cgroup,destination=/sys/fs/cgroup,readonly \
	--mount=type=tmpfs,tmpfs-size=512M,destination=/run \
	--mount=type=tmpfs,tmpfs-size=256M,destination=/tmp \
	$(NAME)

all: image

image:
	docker build \
		--build-arg build_date="${BUILD_DATE}" \
		--build-arg name="${NAME}" \
		--build-arg vcs_ref="${VCS_REF}" \
		--build-arg vcs_url="${VCS_URL}" \
		--build-arg docker_cmd="${DOCKER_CMD}" \
		--build-arg docker_cmd_debug="${DOCKER_CMD_DEBUG}" \
		--pull \
		--tag=$(NAME):build \
		.
.PHONY: image

run:
	$(DOCKER_CMD):build
.PHONY: run

debug:
	$(DOCKER_CMD_DEBUG):build
.PHONY: debug

push:
	docker tag $(NAME):build $(NAME):$(VCS_REF)
	docker tag $(NAME):build $(NAME):latest
	docker push $(NAME):$(VCS_REF)
	docker push $(NAME):latest
.PHONY: push

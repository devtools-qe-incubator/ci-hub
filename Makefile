CONTAINER_MANAGER ?= podman

#### ci-hub-support ####

.PHONY: ci-hub-support-oci-build ci-hub-support-oci-save ci-hub-support-oci-load ci-hub-support-oci-push 

# Variables
CI_HUB_SUPPORT ?= $(shell sed -n 1p ci-hub-support/release-info)
CI_HUB_SUPPORT_V ?= v$(shell sed -n 2p ci-hub-support/release-info)
CI_HUB_SUPPORT_SAVE ?= ci-hub-support

ci-hub-support-oci-build: CONTEXT=ci-hub-support
ci-hub-support-oci-build: MANIFEST=$(CI_HUB_SUPPORT):$(CI_HUB_SUPPORT_V)
ci-hub-support-oci-build:
	${CONTAINER_MANAGER} build -t $(MANIFEST) -f $(CONTEXT)/oci/Containerfile $(CONTEXT)

ci-hub-support-oci-save:
	${CONTAINER_MANAGER} save -o $(CI_HUB_SUPPORT_SAVE).tar $(CI_HUB_SUPPORT):$(CI_HUB_SUPPORT_V)

sci-hub-support-oci-load:
	${CONTAINER_MANAGER} load -i $(CI_HUB_SUPPORT_SAVE).tar 

ci-hub-support-oci-push:
ifndef IMAGE
	IMAGE = $(CI_HUB_SUPPORT):$(CI_HUB_SUPPORT_V)
endif
	${CONTAINER_MANAGER} push $(IMAGE)


 	
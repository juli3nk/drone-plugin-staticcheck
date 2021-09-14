
.PHONY: build
build:
	docker image build \
		-t juli3nk/drone-staticcheck \
		.

.PHONY: push
push:
	docker image push juli3nk/drone-staticcheck

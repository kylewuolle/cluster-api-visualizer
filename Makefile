## --------------------------------------
## Variables
## --------------------------------------

VUE_DIR := web
NODE_MODULES := ./$(VUE_DIR)/node_modules
DIST_FOLDER := ./$(VUE_DIR)/dist
GO_BIN_OUT := main

## --------------------------------------
## All
## --------------------------------------

# Default target is to build and run the app
.PHONY: all
all: npm-install build run

.PHONY: build
build: build-web build-go

.PHONY: clean
clean:
	rm -rf $(DIST_FOLDER) $(NODE_MODULES) $(GO_BIN_OUT) tmp

## --------------------------------------
## Vue and Node
## --------------------------------------

.PHONY: npm-install
npm-install: $(VUE_DIR)/package.json
	npm install --prefix ./$(VUE_DIR)

.PHONY: build-web
build-web: $(NODE_MODULES)
	npm run --prefix ./$(VUE_DIR) build

.PHONY: npm-serve
npm-serve: $(VUE_DIR)/package.json $(NODE_MODULES)
	npm run --prefix ./$(VUE_DIR) serve

.PHONY: clean-dist
clean-dist:
	rm -rf $(DIST_FOLDER)

## --------------------------------------
## Go
## --------------------------------------

.PHONY: build-go
build-go:
	go build -o $(GO_BIN_OUT)

.PHONY: run
run: $(GO_BIN_OUT) $(DIST_FOLDER)
	./$(GO_BIN_OUT)

.PHONY: air
air: .air.toml
	air

.PHONY: go-mod-tidy
go-mod-tidy:
	go mod tidy

.PHONY: go-vet
go-vet:
	go vet ./...

.PHONY: go-fmt
go-fmt:
	go fmt ./...
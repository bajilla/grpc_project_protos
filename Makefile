# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=userservice
PROTO_FILES=proto/user_service/user_service.proto

.PHONY: all build clean test run deps proto

all: clean deps proto build

build:
	$(GOBUILD) -o $(BINARY_NAME) -v

clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f *.pb.go

test:
	$(GOTEST) -v ./...

run: build
	./$(BINARY_NAME)

deps:
	$(GOGET) -v -t -d ./...
	$(GOCMD) mod tidy

proto:
	protoc -I proto $(PROTO_FILES) --go_out=./gen/go --go_opt=paths=source_relative \
		--go-grpc_out=./gen/go --go-grpc_opt=paths=source_relative
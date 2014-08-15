
BIN := ./node_modules/.bin
REPORTER ?= spec
SRC = $(wildcard index.js lib/*.js)
TESTS = $(wildcard test/*.js)

test: node_modules
	@$(BIN)/gnode $(BIN)/_mocha \
		--reporter $(REPORTER) \
		--require co-mocha \
		--timeout 5s

node_modules: package.json
	@npm install
	@touch node_modules

coverage: $(SRC) $(TESTS)
	@$(BIN)/gnode $(BIN)/istanbul cover \
	  $(BIN)/_mocha -- \
	    --reporter $(REPORTER) \
	    --require co-mocha \
	    --timeout 5s

clean:
	rm -rf coverage

.PHONY: test clean

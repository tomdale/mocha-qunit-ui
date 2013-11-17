SRC = src/head.js src/qunit-head.jslike test/qunit/qunit/qunit.js src/qunit-tail.jslike src/ui-head.jslike src/mocha-qunit-ui.js src/ui-tail.jslike src/tail.js

mocha-qunit-ui.js: $(SRC)
	cat $(SRC) > mocha-qunit-ui.js

.PHONY: clean
clean:
	rm mocha-qunit-ui.js

node_modules:
	npm install

.PHONY: expected-failures
expected-failures: node_modules
	@F=0; \
	for f in test/expected-failures/*.js; do \
		node ./test/assert-failures.js $$f; \
		if [ "$$?" -ne 0 ]; then \
			echo "False positive reported by test file '$$f'"; \
			F=1; \
		fi \
	done; \
	exit $$F

.PHONY: test
test: expected-failures

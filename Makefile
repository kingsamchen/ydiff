# Makefile for testing

TESTS = git svn crlf strange

.PHONY: dogfood test $(TESTS) clean sdist

dogfood:
	src/cdiff.py -s
	git diff | src/cdiff.py
	git diff | src/cdiff.py -s

test: $(TESTS)

$(TESTS):
	src/cdiff.py tests/$@.diff
	src/cdiff.py tests/$@.diff -s
	src/cdiff.py tests/$@.diff | diff -u tests/$@.diff -
	python3 src/cdiff.py tests/$@.diff
	python3 src/cdiff.py tests/$@.diff -s
	python3 src/cdiff.py tests/$@.diff | diff -u tests/$@.diff -

clean:
	rm -rf build/ cdiff.egg-info/ dist/

sdist:
	./setup.py sdist

# vim:set noet ts=8 sw=8:

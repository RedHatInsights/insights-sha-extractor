.PHONY: pycco

SOURCES:=$(shell find . -name '*.py')
DOCFILES:=$(addprefix docs/packages/, $(addsuffix .html, $(basename ${SOURCES})))

default: tests

docs/packages/%.html: %.py
	mkdir -p $(dir $@)
	pycco -d $(dir $@) $^

pycco: ${DOCFILES}

tests: unit_tests

unit_tests:
	pytest -v -p no:cacheprovider

coverage:
	pytest -v -p no:cacheprovider --cov schemas/

coverage-report:
	pytest -v -p no:cacheprovider --cov schemas/ --cov-report=html

documentation:
	pydoc3 schemas/validators.py > docs/validators.txt

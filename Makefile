# Release
GPG_ID ?= 92126B54

# Git
GIT := /usr/bin/git
GIT_TAG = $(GIT) tag -au $(GPG_ID)

# Python
PYTHON = /usr/bin/python$(PYTHON_VERSION)
PYTHON_CMD = $(PYTHON) -c
PYTHON_VERSION := 2.7
SETUP = $(PYTHON) setup.py
INSTALL_OPTIONS := -O2
UPLOAD_OPTIONS = --sign --identity=$(GPG_ID)

# System
RM := /bin/rm -f

NAME = $(notdir $(CURDIR))

RELEASE_TAG = v$(shell PYTHONPATH=. $(PYTHON_CMD) 'from $(NAME) import __version__; print __version__')

.PHONY: all
all: build

.PHONY: test
test:
	$(SETUP) test

build: test
	$(SETUP) build

.PHONY: clean
clean: distclean
	-$(RM) -r build isodate-*.egg $(NAME).egg-info
	$(SETUP) clean

.PHONY: install
install:
	$(SETUP) install $(INSTALL_OPTIONS)
	install --mode 644 etc/bash_completion.d/$(NAME) /etc/bash_completion.d/

.PHONY: register
register:
	$(SETUP) register

.PHONY: distclean
distclean:
	-$(RM) -r dist

.PHONY: release
release: test register
	$(SETUP) sdist bdist_egg upload $(UPLOAD_OPTIONS)
	$(GIT_TAG) -m 'PyPI release' $(RELEASE_TAG)

include make-includes/python.mk
include make-includes/variables.mk

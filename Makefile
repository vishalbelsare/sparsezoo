.PHONY: build docs test

BUILDDIR := $(PWD)
PYCHECKDIRS := examples tests src utils scripts notebooks
DOCDIR := docs

# run checks on all files for the repo
quality:
	@echo "Running python quality checks";
	black --check $(PYCHECKDIRS);
	isort --check-only $(PYCHECKDIRS);
	flake8 $(PYCHECKDIRS);

# style the code according to accepted standards for the repo
style:
	@echo "Running python styling";
	black $(PYCHECKDIRS);
	isort $(PYCHECKDIRS);

# run tests for the repo
test:
	@echo "Running python tests";
	@pytest;

# create docs
docs:
	sphinx-apidoc -o "$(DOCDIR)/source/" src/sparsezoo;
	cd $(DOCDIR) && $(MAKE) html;

# creates wheel file
build:
	python3 setup.py sdist bdist_wheel

# clean package
clean:
	rm -rf .pytest_cache;
	rm -rf docs/_build docs/build;
	rm -rf build;
	rm -rf dist;
	rm -rf src/sparsezoo.egg-info;
	find $(PYCHECKDIRS) | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf;
	find $(DOCDIR) | grep .rst | xargs rm -rf;
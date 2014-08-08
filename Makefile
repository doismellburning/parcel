.PHONY: bootstrap
bootstrap:
	cabal install --only-dependencies --enable-tests

.PHONY: test
test:
	cabal test

.PHONY: build
build:
	cabal build

.PHONY: configure
configure:
	cabal configure --enable-tests

.PHONY: clean
clean:
	cabal clean

.PHONY: docs
docs:
	cabal haddock

.PHONY: run
run:
	cabal run

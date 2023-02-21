all: rewrite-dollar-simple-with-stuff

rewrite-dollar-simple-with-stuff:
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple-with-stuff.cep

identity:
	@./fab/fab rewrite-dollar-simple.ohm identity-ceptre.fab support.js <test-simple-with-stuff.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



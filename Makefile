all: rewrite-dollar-simple

rewrite-dollar-simple:
	@cat test-simple.cep
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple.cep

identity:
	@./fab/fab rewrite-dollar-simple.ohm identity-ceptre.fab support.js <test-simple.cep

install: npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



all: production

production:
	./fab/fab ceptre.ohm rewrite-dollar.fab support.js <dc.cep

rewrite-dollar-simple:
	@cat test-simple.cep
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple.cep

rewrite-dollar-simple-with-stuff:
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple-with-stuff.cep

rewrite-dollar:
	@cat test.cep
	@./fab/fab ceptre.ohm rewrite-dollar.fab support.js <test.cep

dev: rewrite-dollar

devs: rewrite-dollar-simple

devstuff: identity-simple-with-stuff rewrite-dollar-simple-with-stuff

identity:
	./fab/fab ceptre.ohm identity-ceptre.fab support.js <dc.cep

identity-simple-with-stuff:
	./fab/fab rewrite-dollar-simple.ohm identity-ceptre.fab support.js <test-simple-with-stuff.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



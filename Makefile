all: production

production:
	./fab/fab ceptre.ohm rewrite-dollar.fab support.js <dc.cep

rewrite-dollar-simple:
	@cat test-simple.cep
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple.cep | sed -E 's/ +/ /g'

rewrite-dollar-simple-with-stuff:
	@cat test-simple-with-stuff.cep
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <test-simple-with-stuff.cep

rewrite-dollar:
	@cat test.cep
	@./fab/fab ceptre.ohm rewrite-dollar.fab support.js <test.cep | sed -E 's/ +/ /g'

dev: rewrite-dollar

devs: rewrite-dollar-simple

devstuff: rewrite-dollar-simple-with-stuff

identity:
	./fab/fab ceptre.ohm identity-ceptre.fab support.js <dc.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



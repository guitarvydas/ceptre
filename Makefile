all:
	./fab/fab ceptre.ohm ceptre.fab support.js <dc.cep
dev:
	./fab/fab ceptre.ohm ceptre.fab support.js <test.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



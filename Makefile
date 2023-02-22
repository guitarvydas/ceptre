all:
	@./fab/fab rewrite-dollar-simple.ohm rewrite-dollar-simple.fab support.js <dc.cep

identity:
	@./fab/fab rewrite-dollar.ohm identity-ceptre.fab support.js <dc.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



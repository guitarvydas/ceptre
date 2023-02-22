all: rewrite-dollar

rewrite-dollar:
	@./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js <dc/dc.cep

identity:
	@./fab/fab rewrite-dollar.ohm identity-ceptre.fab support.js <dc/dc.cep

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



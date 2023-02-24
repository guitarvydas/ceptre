all: rewrite

rewrite:
	@./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js >/tmp/1
	./fab/fab elide.ohm elide.fab support.js </tmp/1

1:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js >/tmp/1

e:
	./fab/fab elide.ohm elide.fab support.js </tmp/1 \
	| sed -E 's/\{ +\}/{}/g'

dev:
	./fab/fab stage.ohm stage.fab support.js </tmp/1 | ./indenter

old-rewrite:
	@./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./vstrip

rewrite-dollar:
	@./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js

identity:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	./fab/fab rewrite-dollar.ohm identity-ceptre.fab support.js

pl:
	@./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./vstrip \
	>dc/swipl/dc.pl

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



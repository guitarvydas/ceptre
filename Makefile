all: rewrite

rewrite:
	@./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <dc/dc.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./fab/fab rulename.ohm rulename.fab support.js \
	| ./fab/fab stage.ohm stage.fab support.js \
	| ./fab/fab defx.ohm defx.fab support.js \
	| ./fab/fab fact.ohm fact.fab support.js
	 

0:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <test.cep >/tmp/0

1: 0
	./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js </tmp/0 >/tmp/1

2: 1
	./fab/fab rulename.ohm rulename.fab support.js </tmp/1 >/tmp/2

3: 2
	./fab/fab stage.ohm stage.fab support.js </tmp/2 >/tmp/3

4: 3
	./fab/fab defx.ohm defx.fab support.js </tmp/3 >/tmp/4

dev: 4
	./fab/fab fact.ohm fact.fab support.js </tmp/4
	./fab/fab fact.ohm fact.fab support.js </tmp/4 >/tmp/5
	cat /tmp/5


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



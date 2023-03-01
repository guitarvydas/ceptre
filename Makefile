all: dc.cst

GRAMMARS=rewrite-nametag.ohm rewrite-dollar.ohm rulename.ohm stage.ohm defx.ohm prefix.ohm fact.ohm
FABS=rewrite-nametag.fab rewrite-dollar.fab rulename.fab stage.fab defx.fab prefix.fab fact.fab

define ceptre2rt
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <$1 \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./fab/fab rulename.ohm rulename.fab support.js \
	| ./fab/fab stage.ohm stage.fab support.js \
	| ./fab/fab defx.ohm defx.fab support.js \
	| ./fab/fab prefix.ohm prefix.fab support.js \
	| ./fab/fab fact.ohm fact.fab support.js >$2
endef
	 
dc.rt: $(GRAMMARS) $(FABS) dc/dc.cep
	$(call ceptre2rt,dc/dc.cep,dc.rt)

dc.cst : dc.rt
	cp dc.rt dc.cst

test.rt:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <test.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./fab/fab rulename.ohm rulename.fab support.js \
	| ./fab/fab stage.ohm stage.fab support.js \
	| ./fab/fab defx.ohm defx.fab support.js \
	| ./fab/fab prefix.ohm prefix.fab support.js \
	| ./fab/fab fact.ohm fact.fab support.js >test.rt
	 
test.cst : test.rt
	cp test.rt test.cst


dev: test.cst
	./fab/fab ceptre2pl.ohm ceptre2pl.fab support.js <test.cst




0:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <test.cep >/tmp/0

1: 0
	./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js </tmp/0 >/tmp/1

2: 1
	./fab/fab rulename.ohm rulename.fab support.js </tmp/1 >/tmp/2

3: 2
	./fab/fab stage.ohm stage.fab support.js </tmp/2 >/tmp/3

4: 3
	./fab/fab defx.ohm defx.fab support.js </tmp/3
	./fab/fab defx.ohm defx.fab support.js </tmp/3 >/tmp/4

5: 4
	./fab/fab prefix.ohm prefix.fab support.js </tmp/4 >/tmp/5

6: 5
	./fab/fab fact.ohm fact.fab support.js </tmp/5
	./fab/fab fact.ohm fact.fab support.js </tmp/5 >/tmp/6
	cat /tmp/6


400:
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <test.cep \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js \
	| ./fab/fab rulename.ohm rulename.fab support.js \
	| ./fab/fab stage.ohm stage.fab support.js \
	| ./fab/fab defx.ohm defx.fab support.js >/tmp/400


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



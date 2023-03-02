all: dc.cst

GRAMMARS=rewrite-nametag.ohm rewrite-dollar.ohm rulename.ohm stage.ohm defx.ohm prefix.ohm fact.ohm
FABS=rewrite-nametag.fab rewrite-dollar.fab rulename.fab stage.fab defx.fab prefix.fab fact.fab

define ceptre2rt
	./fab/fab rewrite-nametag.ohm rewrite-nametag.fab support.js <$1 | tee /tmp/1 \
	| ./fab/fab rewrite-dollar.ohm rewrite-dollar.fab support.js | tee /tmp/2 \
	| ./fab/fab rulename.ohm rulename.fab support.js | tee /tmp/3 \
	| ./fab/fab stage.ohm stage.fab support.js | tee /tmp/4 \
	| ./fab/fab defx.ohm defx.fab support.js | tee /tmp/5 \
	| ./fab/fab prefix.ohm prefix.fab support.js | tee /tmp/6 \
	| ./fab/fab fact.ohm fact.fab support.js >$2
endef
	 
dc.rt: $(GRAMMARS) $(FABS) dc/dc.cep
	$(call ceptre2rt,dc/dc.cep,dc.rt)

dc.cst : dc.rt
	cp dc.rt dc.cst

test.rt: $(GRAMMARS) $(FABS) test.cep
	$(call ceptre2rt,test.cep,test.rt)

test.cst : test.rt
	cp test.rt test.cst

dev: test.cst
	./fab/fab ceptre2pl.ohm ceptre2pl.fab support.js <test.cst



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



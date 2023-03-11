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

define devpl
	./fab/fab c2pl0.ohm c2pl0.fab support.js <$1 >/tmp/10
	./fab/fab c2pl1.ohm c2pl1.fab support.js </tmp/10 >/tmp/11
	./fab/fab c2pl2.ohm c2pl2.fab support.js </tmp/11 >/tmp/12
	./fab/fab c2pl3.ohm c2pl3.fab support.js </tmp/12 >/tmp/13
	./fab/fab c2pl4.ohm c2pl4.fab support.js </tmp/13 >/tmp/14
	./fab/fab c2pl5.ohm c2pl5.fab support.js </tmp/14 >/tmp/15
	./fab/fab c2pl6.ohm c2pl6.fab support.js </tmp/15 >/tmp/16
	./strip.bash /tmp/16 /tmp/17
endef

define devcl
	./fab/fab c2cl0.ohm c2cl0.fab support.js <$1 >/tmp/10
	./fab/fab c2cl1.ohm c2cl1.fab support.js </tmp/10 >/tmp/11
	./fab/fab c2cl2.ohm c2cl2.fab support.js </tmp/11 >/tmp/12
	./fab/fab c2cl3.ohm c2cl3.fab support.js </tmp/12 >/tmp/13
	./fab/fab c2cl4.ohm c2cl4.fab support.js </tmp/13 >/tmp/14
	./fab/fab c2cl5.ohm c2cl5.fab support.js </tmp/14 >/tmp/15
	./fab/fab c2clcleanup.ohm c2clcleanup.fab support.js </tmp/15 >/tmp/16
	./strip.bash /tmp/16 /tmp/17
endef

dev: dc.cst
	$(call devcl,dc.cst)

devsmall: test.cst
	$(call devcl,test.cst)


devpl: dc.cst
	$(call devpl,dc.cst)

devsmallpl: test.cst
	$(call devpl,test.cst)


identity: dc.cst
	./fab/fab c2pl.ohm identity-c2pl.fab support.js <dc.cst

install: repos npmstuff

repos:
	# I've tried multigit on Ubuntu and MacOS
	# If multigit doesn't work on your setup, just 'git clone git@github.com:guitarvydas/fab.git'
	multigit -r

npmstuff:
	npm install ohm-js yargs atob pako



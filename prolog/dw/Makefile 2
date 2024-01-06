LIBSRC=libsrc
ODIN_FLAGS ?= -debug -o:none
0D=0d/odin/0d/*.odin 0d/odin/std/*.odin
D2JDIR=0d/odin/das2json
D2J=$(D2JDIR)/das2json

dev: clean run

run: dw
	./dw main cep0.drawio $(LIBSRC)/transpile.drawio

dw: $(D2J) cep0.drawio
	$(D2J) cep0.drawio
	$(D2J) $(LIBSRC)/transpile.drawio
	odin build . $(ODIN_FLAGS)

$(D2J):
	echo 'Remake das2json'

$(0D):
	echo 'Remake 0D'

clean:
	rm -rf dw dw.dSYM

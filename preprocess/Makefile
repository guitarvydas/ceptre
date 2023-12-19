.PHONY: run check build vsh

ODIN_FLAGS ?= -debug -o:none
0D=../tools/odin/engine/process/*.odin ../tools/odin/engine/0d/*.odin ../tools/odin/engine/registry0d/*.odin
STD=../tools/odin/std/*.odin
D2J=../tools/das2json/das2json
#PREPROCESS_SRC=preprocess.drawio
#PREPROCESS_JSON=preprocess.json
#PREPROCESSED_CEP=../preprocessed.dc.cep


../preprocess.dc.cep: preprocess ../dc.cep forced2j $(0D) $(STD)
	(cd ../tools/das2json ; make)
	./preprocess ../dc.cep >../preprocessed.dc.cep

preprocess.json: preprocess.drawio $(D2J)
	$(D2J) preprocess.drawio

preprocess: preprocess.drawio $(0D) $(STD) preprocess.json
	echo building preprocess
	odin build . $(ODIN_FLAGS) 

forced2j:
	(cd ../tools/das2json ; make)


clean:
	rm -f preprocess
	rm -rf *.dSYM

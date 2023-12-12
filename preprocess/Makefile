.PHONY: run check build vsh

ODIN_FLAGS ?= -debug -o:none
0D=../tools/odin/process/*.odin ../tools/odin/0d/*.odin ../tools/odin/leaf0d/*.odin ../tools/odin/leaf0d/*.odin
D2J=../tools/das2json/das2json
#PREPROCESS_SRC=preprocess.drawio
#PREPROCESS_JSON=preprocess.json
#PREPROCESSED_CEP=../preprocessed.dc.cep

dev: preprocess

../preprocess.dc.cep: preprocess ../dc.cep
	./preprocess ../dc.cep >../preprocessed.dc.cep

preprocess.json: preprocess.drawio $(D2J)
	$(D2J) preprocess.drawio

preprocess: preprocess.drawio $(0D) preprocess.json
	odin build . $(ODIN_FLAGS) 

$(D2J):
	(cd ../tools/das2json ; make)


clean:
	rm -f preprocess
	rm -rf *.dSYM

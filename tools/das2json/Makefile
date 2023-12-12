ODIN_FLAGS ?= -debug -o:none
DAS2JSON=syntax/*.odin

das2json: main.odin $(DAS2JSON)
	@echo 'building das2json'
	odin build . $(ODIN_FLAGS)

clean:
	rm -rf das2json das2json.bin das2json.bin.dSYM /tmp/*.drawio.json


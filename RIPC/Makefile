.DEFAULT_GOAL := RIPC.BIN

RIPC.BIN: Errors.C RIPC.C
	$(CC) RIPC.C -o $@

.PHONY: clean
clean:
	rm -f RIPC.BIN

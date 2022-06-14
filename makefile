JAVA=java
JAVAC=javac

ROOT=.

ANTLR=antlr-4.10.1-complete.jar
ANTLR_PATH=$(ROOT)/tools/$(ANTLR)

CLASS_PATH_OPTION=-cp .:$(ANTLR_PATH)

# Comandos como descritos na página do ANTLR.
ANTLR4=$(JAVA) -jar $(ANTLR_PATH)
GRUN=$(JAVA) $(CLASS_PATH_OPTION) org.antlr.v4.gui.TestRig

# Diretório para aonde vão os arquivos gerados.
GEN_PATH=lexer

# Diretório para os casos de teste
DATA_PATH=$(ROOT)/in

PARSER_PATH=/src/lexer.g


all: antlr javac
	@echo "Done."

antlr: lexer.g
	$(ANTLR4) -o $(GEN_PATH) lexer.g

javac:
	$(JAVAC) $(CLASS_PATH_OPTION) $(GEN_PATH)/*.java

# Veja a explicação no README
run:
	cd $(GEN_PATH) && $(GRUN) EZLexer tokens -tokens $(FILE)

runall:
	-for FILE in $(IN)/*.ezl; do \
	 	cd $(GEN_PATH) && \
	 	echo -e "\nRunning $${FILE}" && \
	 	$(GRUN) EZLexer tokens -tokens $${FILE} && \
	 	cd .. ; \
	done;

clean:
	@rm -rf $(GEN_PATH)

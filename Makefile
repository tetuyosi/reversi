SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main
Main: Reversi.smi Main.smi Reversi.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
Reversi.o: Reversi.sml Reversi.smi
	$(SMLSHARP) $(SMLFLAGS) -o Reversi.o -c Reversi.sml
Main.o: Main.sml Reversi.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml

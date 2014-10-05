# Build the TVM library.
master = Environment()
master.Replace(CC = "avr-gcc")

Export( env = master.Clone() )

SConscript(['runtime/libtvm/Sconscript'])

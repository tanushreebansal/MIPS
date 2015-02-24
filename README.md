# MIPS
Multicycle datapath for MIPS architecture which can execute following  instructions:

                  R-Type
Name	Format	Opcode	rs	rt	rd	shmt	Func
add	    R	      0	    rs	rt	rd	 0	   32
sub	    R 	    0	    rs	rt	rd	 0	   33
and	    R 	    0	    rs	rt	rd	 0	   34
or	    R	      0	    rs	rt	rd	 0	   35
nor	    R 	    0	    rs	rt	rd	 0	   36
sll	    R	      0	    rs	rt	rd	Shmt	 37

                 I-Type
lw	    I	      1	    rs	rt	Offset
sw	    I	      2	    rs	rt	Offset
addi	  I	      3	    rs	rt	Immediate Value
subi	  I	      4	    rs	rt	Immediate Value
beq	    I	      5	    rs	rt	Target address

                 J-Type
j	      J	      6	    Target Address

Assumtion :  1K byte addressable memory  

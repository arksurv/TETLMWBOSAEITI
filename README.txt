The Enormously Terrible Language Made Worse By Our Shortcuts And Errors In The Interpreter (TETLMWBOSAEITI)

TETLMWBOSAEITI, which will from now on be referred to as "The Language" or derivatives, is a horrible language with an interpreter written in Lua. There are many traps, trials, and tribulations to understand how to write in The Language correctly.

Firstly, line numbers play a prominent role in the interpretation of the language. In order to save time declaring comments, every even numbered line has been declared a comment for you. Also reserved exclusively for comments are prime numbered lines, allowing for block comments as neccessary. This also means that comment lines are more overwhelming near the start of the file, as we believe that the earlier parts of a file should be easier to understand.

Make sure to follow all necessary comment documentation procedures.

WARNING: Do NOT leave a line completely blank, every single blank line requires a space. If you do not put a space in your blank lines, they will not count as lines, and your future line numbers will be messed up, which will almost invariably result in a program malfunctioning.

ADDENDUM: This first WARNING is not necessarily an intentional feature. If you would like to fix the line splitting so that it does not do this, be out guest.

WARNING: Do NOT put multiple spaces on a blank line. This is interpreted as a "" operation which, unfortunately, does not exist. Therefore, your program will fail.

WARNING: Your program must have an extra line after the final statement.

The next part of the language is how you will handle data. You will handle data in bytes. These bytes are stored as integers from 0-255. Bytes will be declared automatically when referenced in an operation and will start at 0. If a byte ever exceeds 255 or goes below 0, it will wrap around.

There are currently 11 operations you can do in a line:
	Increment	INC a	Add 1 to the value of {a}
	Decrement	DEC a	Subtract 1 from the value of {a}
	Addition	SUB a b	Add the value of {b} to {a}, modifying {a}
	Subtraction	ADD a b	Subtract the value of {b} from {a}, modifying {a}
	Multiplication	MUL a b Multiply {a} by {b}, modifying {a}
	Division	POW a b Divide {a} by {b} and floor the result, modifying {a}
	Power/Exponent	DIV a b	Raise {a} to the power of {b}, modifying {a}
	Root		IND a b	Find the {b}th root of {a} and floor the result, modifying {a}
	Goto		GOT a..	Jump to the line number defined by the values of all provided bytes. (1 + {a}*1 + {b} * 255 + {c} * 255^2...)
	Output		INO a	Output {a} translated into our revolutionary charset (more info later)
	Input		ONI a..	Input into {a}, {b}, {c}, etc. The first characters of the input string will be converted into bytes using our revolutionary charset and stored in the provided byte references. Will only process as many characters of input as there are bytes for output. Also it's untested.

As mentioned in our operation descriptions, we have created a revolutionary charset optimized for bogosort! There's not much else to say about it, so just take a look for yourself:

	0  1  2  3  4  5  6  7
0	=  1  v  O  p  ~  Y  \a
8	&  "  [  R  x  \r A  T
16	n  \n Q  E  2  u  m  k
24	`  D     M  .  U  \f g
32	W  j  F  w  )  <  \v l
40	B  s  *  ]  @  b  N  X
48	}  6  y  P  c  7  a  !
56	i  3  $  8  >  +  _  /
64	t  {  C  d  :  K  q  |
72	S  ;  \  h  o  G  V  f
80	4  J  9  e  #  r  ,  H
88	5  (  \t ?  0  -  Z  z
96	%  ^  L  I  '

Outputting a byte that has a value outside of the defined character set will output an empty string.

There are many features that still need to be implemented including:
	Randomization features
	Stacks and/or arrays
	JumpIfs/BranchIfs
	Possibly ExecuteIfs

We wish you the best of luck and the highest amounts of fun writing in The Language (TETLMWBOSAEITI).

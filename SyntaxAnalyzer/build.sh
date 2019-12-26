bison -dy -ostmt-gram.c -v syn_anlz.y
gcc -g -Wall -DGENERATED_PARSEER -c -o stmt-gram.o stmt-gram.c
flex -ostmt-lexl.c lex_anlz.l
gcc -c -DGENERATED_PARSER -o stmt-lexl.o stmt-lexl.c
gcc stmt-gram.o stmt-lexl.o -o ex1

use warnings;
open(FH, '<', $ARGV[0]) or die $!;
my $funcs = "";
my $script = "";
while(<FH>){
    $script = $script . $_;
    if ($_ =~ /^ *sub [\w_]* /) {
        my $n = $_;
        $n =~ s/^ *sub ([\w_]*) .*/$1/;
        $n =~  s/\n//; # ???
        $funcs = $funcs . "void perl(){if(!_pl_init){_pl_init=1;perl_init();}call_argv(\"${n}\", G_DISCARD | G_NOARGS, args);}";
    }
}
$script =~ s/\n/\\n/g;
$script =~ s/"/\\"/g;
close(FH);
my $c = "#include <EXTERN.h>
#include <perl.h>
static PerlInterpreter *my_perl;char *args[]={NULL};int _pl_init=0;int perl_init(){int argc=3;char **argv=(char**)malloc(sizeof(char*));argv[0]=strdup(\"hi\");argv[1]=strdup(\"-e\");argv[2]=strdup(\"${script}\");my_perl=perl_alloc();perl_construct(my_perl);perl_parse(my_perl, NULL, argc, argv, NULL);}" . $funcs;
open(my $FH, '>', $ARGV[1]) or die $!;
print $FH $c; 
close $FH;
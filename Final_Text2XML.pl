use Data::Dumper;
use strict;

my @data;
my $final = {};
while (<DATA>){
	last if /^__END__$/;         # stop when __END__ is encountered
	s/\n//gsi;
	s/=/./gsi;
	push (@data,$_);
}

foreach (@data){
	createHash($_);
}
print Dumper(\$final);

use XML::Simple;
my $path = 'text2xml.xml';
open my $fh, '>:encoding(iso-8859-1)', $path or die "open($path): $!";
XMLout($final, OutputFile => $fh);

sub createHash{
	
	my $val = shift;
	my @x = split('\.',$val); 
	my $i = 0;
	my $f = {};
	while($i < scalar(@x)){
		
		if($x[$i+2]){
			#$f->{$x[$i+1]} = '['.$x[$i+2].']';
			$f->{$x[$i+1]} = $x[$i+2];
		}	
		
		if(exists($final->{$x[$i]})){
			$final->{$x[$i]}->[1] = ($final, $f);
		}
		else{
			$final->{$x[$i]}->[0] = ($final, $f);
		}
		
		$i = $i+3;
	}

}



__DATA__
a.c=xyz
a.b=abc
b.c=qqq
a.d=www
b.z=zzz

__END__

## expected output
<opt>
  <a c="[xyz]" />
  <a d="[www]" />
  <b c="[qqq]" />
  <b z="[zzz]" />
</opt>


%h->{a}->{b} = 'abc'
%h->{a}->{c} = 'xyz'
%h->{a}->{d} = 'www'
%h->{b}->{z} = 'zzz'
%h->{b}->{c} = 'qqq'
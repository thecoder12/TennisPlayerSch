
	use Data::Dumper;
	use LWP::Simple;

	
	## ATP Players extract
	my $url = 'http://tennisabstract.com/reports/atpRankings.html';
	$content = _connect($url);
	$content =~ s/&nbsp;/ /gsi;
	my @TopATP_Players = $content =~ />([a-zA-Z ]*)<\/a>/gsi;
	

	
	## WTA Players extract
	my $url = 'http://tennisabstract.com/reports/wtaRankings.html';
	$content = _connect($url);
	$content =~ s/&nbsp;/ /gsi;
	my @TopWTA_Players = $content =~ />([a-zA-Z ]*)<\/a>/gsi;
	open (MYFILE, '>WTARankings.html'); 
	print MYFILE $_."\n" foreach @TopWTA_Players;
	close (MYFILE);
	
	
sub _connect{
	
	my $url = shift @_;
	
	my $content = get $url;
	die "Couldn't get $url" unless defined $content;
	
	return($content);
}


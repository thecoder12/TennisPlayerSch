
use Data::Dumper;
my %Player;
$Player{'Name'} = 'Marin Cilic' ;
# $Player{'Name'} = 'Novak Djokovic' ;
# $Player{'Name'} = 'Rafael Nadal' ;
# $Player{'Name'} = 'Roger Federer' ;
my $url = 'http://www.bing.com/search?q='.$Player{'Name'};
	# Just an example: the URL for the most recent /Fresh Air/ show

	use LWP::Simple;
	my $content = get $url;
	die "Couldn't get $url" unless defined $content;

	if($content =~ /<li class="b_ans.*>(.*?)<\/li>/gsi){	
		# open (MYFILE, '>BingGetPlayerScheduleNOvak.html'); print MYFILE $1; close (MYFILE);  
		 $table = $1;
	}	 
		print 'Content not found' if  !defined $table;
		
		if( $table =~ /Starts at ([\d:]*) ([A-Z]*)/gsi){
			$Player{'Time'} = $1;
			$Player{'TimeZone'} = $2;			
		}
		if($table =~ /<td>([A-Za-z]*) ([0-9]*)<\/td>/){
			# print "=$1=$2=";
			$Player{'Month'} = $1;
			$Player{'Date'} = $2;
			$Player{'StartsAt'} = $1.' '.$2;
	
		}
		if($table =~ /<td class="grcs">(.*?)<\/td>/gsi){
			$Player{'round'} = $1;
		}
		## h="ID=SERP,5303.1">
		if($table =~ /h="ID=SERP,5303.1">(.*?)<\/a>/gsi){
			$Player{'vs'} = $1;
		}
		## h="ID=SERP,5298.1">Philipp Kohlschreiber</a>
		elsif($table =~ /h="ID=SERP,5298.1">(.*?)<\/a>/gsi){
			$Player{'vs'} = $1;
		}
		## <td class="grcs">
		if($table =~ /<td class="grcs">(.*?)<\/td>/gsi){
			$Player{'court'} = $1;
		}
		## <span class="sb_meta b_secondaryText">LIVE</span>
		if($table =~ /<td><span class="sb_meta b_secondaryText">(.*?)<\/span><\/td>/gsi){
			$Player{'live'} = $1;
		}

	     
	print Dumper(\%Player);

	
	

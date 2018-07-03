my @tape = ();
my $index = 0;
my @commands = ();
while ($l=<>){
	for $c (split / /,$l){
		push @commands,$c;
	}
}

for $c (@commands){
	if($c =~ m'^%(\+\+|--|#|&|%)$'){
		if($1 eq '++'){$tape[$index] += 1}
		if($1 eq '--'){$tape[$index] -= 1}
		if($1 eq '#'){$index += 1}
		if($1 eq '%'){$index = 0}
		if($1 eq '&'){$tape[$index] = ord(getc)}
	}
	if($c =~ m'^#(#|%)$'){
		for $i(0..@tape){
		if($1 eq '%'){$tape[$i] = 1}
		if($1 eq '#'){$tape[$i] = 0}
		}
	}
	if($c =~ m'^(%|\*+)(\+|-|\^|$|&)(%|\*+)$'){
		my $i,$j;
		if($1 eq '%'){$i=$index}
		else {$i=(length$1)-1}
		if($3 eq '%'){$j=$index}
		else {$j=(length$3)-1}
		if($2 eq '+'){$tape[$i] += $tape[$j]}
		if($2 eq '-'){$tape[$i] -= $tape[$j]}
		if($2 eq '&'){$tape[$i] *= $tape[$j]}
		if($2 eq '$'){$tape[$i] /= $tape[$j]}
		if($2 eq '^'){$tape[$i] **= $tape[$j]}
	}
	if($c =~ m'^(@|@@)(%|\*+)$'){
		my $i;
		if($2 eq '%'){$i=$index}
		else {$i=(length$2)-1}
		if($1 eq '@'){print (chr($tape[$i]+(ord'@')))}
		if($1 eq '@@'){print ($tape[$i])}
	}
}


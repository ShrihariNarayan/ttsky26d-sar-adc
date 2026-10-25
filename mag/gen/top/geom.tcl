load ana
select top cell
puts "ANABB [box values]"
flatten ana_flat
load ana_flat
gds write ana_flat.gds
quit -noprompt

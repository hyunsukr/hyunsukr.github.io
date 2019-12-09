data data;
infile '/folders/myshortcuts/SAS/final/data.csv' dlm=',' firstobs=2;
input Hour	TempFeel	Humidity	Count;
run;


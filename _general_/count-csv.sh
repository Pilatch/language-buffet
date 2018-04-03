outFile=counts.csv
mainsDir=mains-sans-comments
echo extension,non-blank lines,characters > $outFile

for f in $(ls $mainsDir)
do
  filename=$(basename -- "$f")
  extension="${f##*.}"
  nonBlankLines=$(cat $mainsDir/$f | sed '/^\s*$/d' | wc -l)
  characters=$(cat $mainsDir/$f | sed '/^\s*$/d' | wc -c)
  echo $extension,$nonBlankLines,$characters >> $outFile
done

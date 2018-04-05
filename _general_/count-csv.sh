outFile=counts.csv
mainsDir=mains-sans-comments
echo extension,non-blank lines,characters > $outFile

for f in $(ls $mainsDir)
do
  filename=$(basename -- "$f")
  extension="${f##*.}"
  lines=$(cat $mainsDir/$f | sed '/^\s*$/d' | wc -l)
  characters=$(cat $mainsDir/$f | tr -d '[:space:] ' | wc -c)
  echo $extension,$lines,$characters >> $outFile
done

mainsDir=mains-sans-comments
lines=$(cat mains-sans-comments/* | sed '/^\s*$/d' | wc -l)
characters=$(cat mains-sans-comments/* | tr -d '[:space:] ' | wc -c)
numFiles=$(ls $mainsDir | wc -w)
averageLinesPerFile=$(expr $lines / $numFiles)
averageCharactorsPerFile=$(expr $characters / $numFiles)
echo Number of files: $numFiles
echo Total non-blank lines: $lines
echo Total non-whitespace characters: $characters
echo Average non-blank lines per file: $averageLinesPerFile
echo Average non-whitespace characters per file: $averageCharactorsPerFile
echo

for f in $(ls $mainsDir)
do
  filename=$(basename -- "$f")
  extension="${f##*.}"
  echo $extension
  echo Lines: $(cat $mainsDir/$f | sed '/^\s*$/d' | wc -l)
  echo Characters: $(cat $mainsDir/$f | tr -d '[:space:] ' | wc -c)
  echo
done

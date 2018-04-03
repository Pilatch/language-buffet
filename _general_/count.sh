mainsDir=mains-sans-comments
nonBlankLines=$(cat mains-sans-comments/* | sed '/^\s*$/d' | wc -l)
characters=$(cat mains-sans-comments/* | sed '/^\s*$/d' | wc -c)
numFiles=$(ls $mainsDir | wc -w)
averageLinesPerFile=$(expr $nonBlankLines / $numFiles)
averageCharactorsPerFile=$(expr $characters / $numFiles)
echo Number of files: $numFiles
echo Total non-blank lines: $nonBlankLines
echo Total characters: $characters
echo Average non-blank lines per file: $averageLinesPerFile
echo Average characters per file: $averageCharactorsPerFile
echo

for f in $(ls $mainsDir)
do
  filename=$(basename -- "$f")
  extension="${f##*.}"
  echo $extension
  echo Non-blank lines: $(cat $mainsDir/$f | sed '/^\s*$/d' | wc -l)
  echo Characters: $(cat $mainsDir/$f | sed '/^\s*$/d' | wc -c)
  echo
done

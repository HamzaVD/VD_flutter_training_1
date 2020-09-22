// Assignment: Read text from a file and find words that appear most in a line in the file.
// (i) finding the highest frequency word(s) in each line
// (ii) finding lines in the file whose "highest frequency words" is the greatest value among all lines.
// Print the result in the following format:
// The following words have the highest word frequency per line:
// ["word1"] (appears in line #)
// ["word2", "word3"] (appears in line #)

import 'dart:io';

main() {
  readFileAndProcess('input_data.txt');
}

readFileAndProcess(String fileName) {
  var myFile = new File(fileName);
  List<String> linesInFile = myFile.readAsLinesSync();
  Map<String, int> happeningWordsInFile = new Map();
  print("The following words have the highest word frequency per line:");
  for (int i = 0; i < linesInFile.length; i++) {
    Map<String, int> temp = processLine(linesInFile[i], i);
    happeningWordsInFile[temp.keys.first] = temp.values.first;
  }
  findMax(happeningWordsInFile);
}

Map<String, int> processLine(String singleLine, int index) {
  List<String> wordsInLine =
      singleLine.replaceAll('.', '').toLowerCase().split(' ');
  return findMax(prepareMap(wordsInLine), lineIndex: index);
}

Map<String, int> prepareMap(List<String> wordsInLine) {
  Map<String, int> wordCountInLine = new Map();
  wordsInLine.forEach((singleWord) {
    if (wordCountInLine.containsKey(singleWord))
      wordCountInLine[singleWord] += 1;
    else
      wordCountInLine[singleWord] = 1;
  });
  return wordCountInLine;
}

Map<String, int> findMax(Map<String, int> wordsAndCountInLine,
    {int lineIndex}) {
  int maxHappeningWordIndex = wordsAndCountInLine.values.first;
  String maxHappeningWord = wordsAndCountInLine.keys.first;
  wordsAndCountInLine.forEach((key, value) {
    if (value > maxHappeningWordIndex) {
      maxHappeningWordIndex = value;
      maxHappeningWord = key;
    }
  });
  if (lineIndex != null)
    print('[$maxHappeningWord] (appears in line ${lineIndex + 1})');
  else
    print('[$maxHappeningWord] (appears most in file)');
  return {maxHappeningWord: maxHappeningWordIndex};
}

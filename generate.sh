#!/bin/szh

# Abstract out file names:
CORPUS="CORPUS.txt"
OUTPUT="Frankenstein's Governess.txt"

# Start with a new line, designated in the corpus by an @ character
LLMIN="@"

# Iterations count words (or spaces, really)
ITER=0

# Repeat while the wordcount is less than 50,000
while [ $ITER -lte 50000 ]
do
  # Search the text for the input phrase, plus one additional wildcard character, returning one random result
  LLMOUT=$(grep -o -E -e "${LLMIN}." "$CORPUS" | shuf -n 1)

  # Print the wildcard match to the output
  printf "%s" ${LLMOUT:(-1)} | sed -e 's/\@/\n/g' >> "$OUTPUT"

  # Count each space as a "word"
  [[ "${LLMOUT:(-1)}" == " " ]] && ITER=$((ITER+1))

  # Append the output character to the input phrase, limiting the input to 16 characters long. Also escape regex wildcard tokens.
  LLMIN=$(echo ${LLMOUT:(-16)} | sed -E -e 's/([?().])/\\\1/g')

  # Loop with that as the input...
done

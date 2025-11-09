#!/usr/bin/bash
# Periodic Table Lookup Script

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"

MAIN_SCRIPT() {
  # 1️⃣ Check for argument
  if [[ -z $1 ]]; then
    echo "Please provide an element as an argument."
    exit
  fi

  # 2️⃣ Build condition based on input type (number or text)
  if [[ $1 =~ ^[0-9]+$ ]]; then
    CONDITION="e.atomic_number = $1"
  else
    CONDITION="LOWER(e.name) = LOWER('$1') OR LOWER(e.symbol) = LOWER('$1')"
  fi

  # 3️⃣ Query database
  ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, 
                          p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
                   FROM elements e
                   JOIN properties p ON e.atomic_number = p.atomic_number
                   JOIN types t ON p.type_id = t.type_id
                   WHERE $CONDITION;")

  # 4️⃣ Handle no result
  if [[ -z $ELEMENT ]]; then
    echo "I could not find that element in the database."
    exit
  fi

  # 5️⃣ Parse and print formatted output
  echo "$ELEMENT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
}

MAIN_SCRIPT "$1"

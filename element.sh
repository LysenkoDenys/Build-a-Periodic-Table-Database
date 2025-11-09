#!/usr/bin/bash
# Define a reusable PSQL command with flags:
# -X: do not read startup files
# --tuples-only: show only data rows, no headers
# --no-align: output unaligned text (easier to parse in bash)
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"

# ---------- Main function ----------
MAIN_SCRIPT() {
  # Check if user provided an argument (element name, symbol, or number)
  if [[ -z $1 ]]
  then
    # No argument -> print help message and exit
    echo "Please provide an element as an argument."
    exit
  else
    # Query the database for the element.
    # It checks if $1 matches either atomic_number, name, or symbol.
    ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, 
                            p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
                     FROM elements e
                     JOIN properties p ON e.atomic_number = p.atomic_number
                     JOIN types t ON p.type_id = t.type_id
                     WHERE e.atomic_number::text='$1' 
                        OR e.name='$1' 
                        OR e.symbol='$1';")

    # If the query returned nothing (no such element found)
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
      exit
    else
      # Clean up spaces and split columns by '|'
      # IFS (Internal Field Separator) defines what separates values when reading.
      # The sed command removes leading/trailing spaces and normalizes spacing around '|'.
      echo "$ELEMENT" | sed 's/^ *//g; s/ *$//g; s/ *| */|/g' | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
      do
        # Display the formatted element info
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
}

# ---------- Script entry point ----------
# Pass the first command-line argument ($1) to the main function
MAIN_SCRIPT "$1"

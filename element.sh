#!/usr/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"


MAIN_SCRIPT(){
      if [[ -z $1 ]]
      then
# if no arguments
        echo "Please provide an element as an argument."
        exit
      else
        ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number
JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number::text='$1' OR e.name='$1' OR e.symbol='$1';")
# if ELEMRENT is empty 
            if [[ -z $ELEMENT ]]
            then
                  echo "I could not find that element in the database."
                  exit
# if ELEMRENT is not empty
            else
                  echo "$ELEMENT" | sed 's/^ *//g; s/ *$//g; s/ *| */|/g' | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
                        do
                              echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
                        done
            fi
  fi

}
MAIN_SCRIPT "$1"
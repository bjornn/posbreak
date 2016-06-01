# POSBREAKS

POSBREAKS is a command line utility that converts a fixed field file into a dsv or csv file using a header description file.

The header description file contains one row with a listing of field size (number of positions) and field 
names. The header file also defines the delimiter character to be used. Valid delimiter characters are: '|', ';', ':'. 
If none of these characters are found in the header file, the default delimiter '|' is used.

An example of a header file is included in this distribution (aHeader.csv):

    1 PostA|4 PostB|5 Post C|5 PostD|5 PostE|5 PostF|4 PostG

When this header is applied to a file containing the following rows (a.dat) 
      
    11111222223333344444555556666
    21111222223333344444555556666
    31111222223333344444555556666
    41111222223333344444555556666
    51111222223333344444555556666
    61111222223333344444555556666
    71111222223333344444555556666
    81111222223333344444555556666
    91111222223333344444555556666
    
By using the command 

    pb2 a.dat aHeader.csv

The result will be

    1 PostA|4 PostB|5 Post C|5 PostD|5 PostE|5 PostF|4 PostG
    1|1111|22222|33333|44444|55555|6666
    2|1111|22222|33333|44444|55555|6666
    3|1111|22222|33333|44444|55555|6666
    4|1111|22222|33333|44444|55555|6666
    5|1111|22222|33333|44444|55555|6666
    6|1111|22222|33333|44444|55555|6666
    7|1111|22222|33333|44444|55555|6666
    8|1111|22222|33333|44444|55555|6666
    9|1111|22222|33333|44444|55555|6666

This output format can be easily viewed or loaded in a csv-parsing spreadsheet application.

## Building
This project uses Haskell standard distribution packages and can thus be easily built from the command line with the command

    ghc -o pb2 Main.hs
    
A binary for Windows (pb2.exe) is distributed from this site.

## Caveats

* The program has only been verified to work properly with Swedish characters ÅÄÖåäö for the following character encoding tables: Latin-1, UTF-8.
* The program has not been tested with large files (megabytes).
* The default separator is defined to be '|' since legacy systems are known to make creative use of ';' when extending their interfaces as separator within columns.


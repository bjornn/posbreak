module Posbreak2Tests where
import Posbreak2
import qualified Data.ByteString.Char8 as B

test1 () =       
  let 
    posbreaks = [5, 10, 15, 20, 25]
    testdata = "1111122222333334444455555" 
    result = pb 0 "" posbreaks testdata
  in 
    case result == "11111|22222|33333|44444|5555" of
      True -> "Test passed."
      False -> "Test failed. " ++ (show result)
    
test2 () = 
  let 
    hdata   = B.pack "5 f1;5 f2;5 f3;5 f4;4 f5"
    testData = "1111122222333334444455555" 
    positions = parsePositions hdata
    result = pb 0 "" positions testData
  in
    case result == "11111|22222|33333|44444|5555" of
      True -> "Test passed."
      False -> "Test failed. " ++ (show result)    
      
test3 () = do
  hdata <- B.readFile "aHeader.csv"
  testData <- readFile "a.dat"
  let positions = parsePositions hdata
  putStrLn $ unlines $ [B.unpack hdata] ++ (map (pb 0 "" positions) (lines testData))
    
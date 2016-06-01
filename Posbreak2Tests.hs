module Posbreak2Tests where
import Posbreak2
import qualified Data.ByteString.Char8 as B

test1 () =       
  let 
    posbreaks = [5, 10, 15, 20, 25]
    testdata = "1111122222333334444455555" 
    result = pb 0 "" posbreaks testdata
  in 
    case result == "11111|22222|33333|44444|55555" of
      True -> "Test 1 PASS."
      False -> "Test 1 FAIL. " ++ (show result)
    
test2 () = 
  let 
    hdata   = B.pack "5 f1|5 f2|5 f3|5 f4|4 f5"
    testData = "111112222233333444445555" 
    positions = parsePositions hdata
    result = pb 0 "" positions testData
  in
    case result == "11111|22222|33333|44444|5555" of
      True ->  "Test 2 PASS."
      False -> "Test 2 FAIL. " ++ (show result)    
      
test3 () = 
  -- Testdata contains more characters than the reading frame implies. 
  -- Need to warn or sufficiently good if lines are not truncated?
  let 
    hdata   = B.pack "5 f1|5 f2|5 f3|5 f4|4 f5"
    testData = "1111122222333334444455555" 
    positions = parsePositions hdata
    result = pb 0 "" positions testData
  in
    case result == "11111|22222|33333|44444|5555|5" of
      True ->  "Test 3 PASS."
      False -> "Test 3 FAIL. " ++ (show result)          
      
test4 () = do
  hdata <- B.readFile "aHeader.csv"
  testData <- readFile "a.dat"
  let positions = parsePositions hdata
  return $ "Test 3:\n " ++ (unlines $ [B.unpack hdata] ++ (map (pb 0 "" positions) (lines testData)) )
    
runtests = do
  putStrLn $ test1()
  putStrLn $ test2()
  putStrLn $ test3()
  x <- test4()
  putStrLn x  
  putStrLn "All tests run."
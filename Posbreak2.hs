module Posbreak2 where
import qualified Data.ByteString.Char8 as B

defaultDelimiter = '|'
    
detectDelimiter :: String -> Char
detectDelimiter [] = defaultDelimiter
detectDelimiter (c:aString) =
  let
    knownDelimiters = [';',':','|']

  in
    case elem c knownDelimiters of
      True -> c
      False -> detectDelimiter aString

pb :: Char -> Integer -> String -> [Integer] -> String -> String
pb delimiter pos result breaklist []         = result
pb delimiter pos result []        indata     = result ++ indata
pb delimiter pos result breaklist (n:indata) = 
  if pos == (head breaklist)
    then pb delimiter (pos + 1) (result ++ [delimiter] ++ [n]) (tail breaklist) indata 
    else pb delimiter (pos + 1) (result ++ [n])  breaklist indata 

posAccumulate _ [] result = result
posAccumulate startN listN result =
  posAccumulate (startN + (head listN)) (tail listN) (result ++ [startN + (head listN)])

parsePositions headData =
  let
    delimiter = detectDelimiter $ B.unpack headData
    positions = [B.readInteger ((B.split ' ' h) !! 0)| h <- B.split delimiter headData]
    parseStatus = map (\x -> if x == Nothing then False else True) positions
  in  
    if not (and parseStatus)
      then error ("Header parsing failed: Could not find integer in first position. " ++ show positions )
      else (posAccumulate 0 [i | Just(i,s) <- positions] [])


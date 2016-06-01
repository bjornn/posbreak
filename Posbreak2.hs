module Posbreak2 where
import qualified Data.ByteString.Char8 as B

pbdebug :: Integer -> String -> [Integer] -> String -> String
pbdebug pos result (bhead:breaklist) (n:indata) = show (if pos == bhead then False else True)

pb :: Integer -> String -> [Integer] -> String -> String
pb pos result breaklist []         = result
pb pos result []        indata     = result ++ indata
pb pos result breaklist (n:indata) = 
  let 
    breakStr = "|"
  in
    if pos == (head breaklist)
      then pb (pos + 1) (result ++ breakStr ++ [n]) (tail breaklist) indata 
      else pb (pos + 1) (result ++ [n])  breaklist indata 

doPosbreak = (pb 0 "")

posAccumulate _ [] result = result
posAccumulate startN listN result =
  posAccumulate (startN + (head listN)) (tail listN) (result ++ [startN + (head listN)])

parsePositions headData =
  let 
    positions = [B.readInteger ((B.split ' ' h) !! 0)| h <- B.split '|' headData]
    parseStatus = map (\x -> if x == Nothing then False else True) positions
  in  
    if not (and parseStatus)
      then error ("Header parsing failed: Could not find integer in first position. " ++ show positions )
      else (posAccumulate 0 [i | Just(i,s) <- positions] [])


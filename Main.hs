module Main where
import System.Environment
import Posbreak2
import qualified Data.ByteString.Char8 as B

main = do
  [docFileName, headerFileName] <- getArgs
  pdata <- readFile docFileName
  hdata <- B.readFile headerFileName
  let delimiter = detectDelimiter B.unpack hdata
  let positions = parsePositions hdata
  putStrLn $ unlines $ [B.unpack hdata] ++ (map (pb delimiter 0 "" positions) (lines pdata))
  
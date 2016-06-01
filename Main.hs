module Main where
import System.Environment
import Posbreak2
import qualified Data.ByteString.Char8 as B

main = do
  [docFileName, headerFileName] <- getArgs
  pdata <- readFile docFileName
  hdata <- B.readFile headerFileName
  let positions = parsePositions hdata
  putStrLn $ unlines $ [B.unpack hdata] ++ (map (pb 0 "" positions) (lines pdata))
  
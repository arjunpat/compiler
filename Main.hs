-- currently parser for Kaleidoscope lang
-- https://llvm.org/docs/tutorial/OCamlLangImpl1.html
-- will expand the language with more features (Kaleidoscope++??)

module Main where

import Parser

import Control.Monad.Trans
import System.Console.Haskeline

process :: String -> IO ()
process line = do
  let res = parseToplevel line
  case res of
    Left err -> print err
    Right ex -> mapM_ print ex

main :: IO ()
main = runInputT defaultSettings loop
  where
    loop = do
      minput <- getInputLine "kl>"
      case minput of
        Nothing -> outputStrLn "Bye!"
        Just input -> (liftIO $ process input) >> loop


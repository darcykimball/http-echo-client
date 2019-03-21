{-# LANGUAGE OverloadedStrings #-}
module Shout (
    randomShout
  , shoutRequest
  ) where


import Network.HTTP.Client
import Network.HTTP.Types.Status
import System.Random


import qualified Data.ByteString.Lazy as LB


-- Send some plaintext as a POST
shoutRequest :: String -> LB.ByteString -> IO Request
shoutRequest reqStr payload = do
  initialRequest <- parseRequest reqStr
  return $
    initialRequest {
      method = "POST"
    , requestBody = RequestBodyLBS payload
    }


randomShout :: IO String
randomShout = do
  index <- randomRIO (0, length proclamations - 1)
  return $ proclamations !! index
  where
    proclamations = [
        "Tacos are the best"
      , "Clapton is God"
      , "When in doubt, you are abusing unsafePerformIO"
      , "C has the power of assembly and the portability of assembly"
      , "Peace comes from within, not without"
      , "Separate side-effects from computation when possible"
      , "CCSD(T) is gold. Quantum computing is alchemy."
      ] 

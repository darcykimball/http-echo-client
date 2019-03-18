{-# LANGUAGE OverloadedStrings #-}
module Shout (
    shoutRequest
  ) where


import Network.HTTP.Client
import Network.HTTP.Types.Status


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

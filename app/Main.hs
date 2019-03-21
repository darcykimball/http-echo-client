{-# LANGUAGE OverloadedStrings #-}
module Main where


import Network.HTTP.Client
import Network.HTTP.Types.Status
import Options.Applicative


import qualified Data.ByteString.Lazy.Char8 as C


import Shout


main :: IO ()
main = do
  servInfo@(ServerInfo host port) <- execParser optParseInfo
  putStrLn "Starting client with:"
  print servInfo
  
  -- Send something
  manager <- newManager defaultManagerSettings

  proclamation <- C.pack <$> randomShout

  req <- shoutRequest
           ("http://" <> host <> ":" <> show port) proclamation

  resp <- httpLbs req manager
  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus resp)
  print $ responseBody resp


--
-- Command-line options
--


data ServerInfo = ServerInfo {
    _hostName :: String
  , _port :: Port
  } deriving (Show, Eq, Ord)


type Port = Int


serverInfo :: Parser ServerInfo
serverInfo =
  ServerInfo
    <$> strOption
        ( long "hostname"
       <> metavar "HOST"
       <> help "Echo server hostname"
        )
    <*> option auto
        ( long "port"
       <> help "Echo service port number"
       <> value 3000
        ) 


optParseInfo :: ParserInfo ServerInfo
optParseInfo = info serverInfo fullDesc

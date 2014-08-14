module Parcel.FPM (
    fpm
) where

import Parcel.Config

import Data.Maybe
import System.Process

fpm :: ParcelConfig -> IO () -- TODO Make this Either [Errors] (IO ())
fpm config =
    let
        command = fromJust $ fpmCommand config -- TODO Nope
        ex = concatMap (\x -> ["--exclude", x]) $ fromJust $ exclude config :: [String]-- TODO Nope
        prefix = "/opt/" ++ (fromJust $ organisation config) ++ "/" ++ (fromJust $ packageName config)
        args =
            [ "-s", "dir"
            , "-t", outputTypeToFPMString $ fromJust $ outputType config -- TODO Nope
            , "--name", fromJust $ packageName config
            , "--prefix", prefix
            ] ++ ex ++ ["."]
    in
        callProcess command args

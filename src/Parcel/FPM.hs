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
        args =
            [ "-s", "dir"
            , "-t", outputTypeToFPMString $ fromJust $ outputType config -- TODO Nope
            ]
    in
        callProcess command args

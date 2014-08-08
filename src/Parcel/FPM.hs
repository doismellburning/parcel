module Parcel.FPM (
    fpm
) where

import Parcel.Config

import System.Process

fpm :: ParcelConfig -> IO ()
fpm config =
    let
        command = fpmCommand config
        args = []
    in
        callProcess command args

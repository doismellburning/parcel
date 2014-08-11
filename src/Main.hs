import Parcel.Config
import Parcel.FPM

import System.Environment

main =
    let
        argv = getArgs
        parcelConfig = parseOptions `fmap` argv :: IO ParcelConfig
        c = fmap (merge defaultParcelConfig) parcelConfig
    in
        fpm =<< c

module Parcel.Config (
    ParcelConfig
    , defaultParcelConfig
    , fpmCommand
    , merge
) where

data ParcelConfig = ParcelConfig {
    fpmCommand :: FilePath
} deriving (Show)

merge :: ParcelConfig -> ParcelConfig -> ParcelConfig
merge = undefined

defaultParcelConfig :: ParcelConfig
defaultParcelConfig = ParcelConfig { fpmCommand = "fpm" }

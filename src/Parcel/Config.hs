module Parcel.Config (
    ParcelConfig
    , defaultParcelConfig
    , fpmCommand
    , merge
) where

data ParcelConfig = ParcelConfig
    { fpmCommand :: Maybe FilePath
} deriving (Show)

merge :: ParcelConfig -> ParcelConfig -> ParcelConfig
merge a b =
    ParcelConfig
        { fpmCommand = maybeMerge (fpmCommand a) (fpmCommand b)
        }

maybeMerge :: Maybe a -> Maybe a -> Maybe a
maybeMerge x Nothing = x
maybeMerge _ (Just x) = Just x

defaultParcelConfig :: ParcelConfig
defaultParcelConfig = ParcelConfig { fpmCommand = Just "fpm" }

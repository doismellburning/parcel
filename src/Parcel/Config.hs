module Parcel.Config (
    ParcelConfig
    , defaultParcelConfig
    , fpmCommand
    , merge
) where

data OutputType = Deb deriving (Eq, Show)

outputTypeToFPMString :: OutputType -> String
outputTypeToFPMString Deb = "deb"

data ParcelConfig = ParcelConfig
    { fpmCommand :: Maybe FilePath
    , outputType :: Maybe OutputType
} deriving (Show)

merge :: ParcelConfig -> ParcelConfig -> ParcelConfig
merge a b =
    ParcelConfig
        { fpmCommand = maybeMerge (fpmCommand a) (fpmCommand b)
        , outputType = maybeMerge (outputType a) (outputType b)
        }

maybeMerge :: Maybe a -> Maybe a -> Maybe a
maybeMerge x Nothing = x
maybeMerge _ (Just x) = Just x

defaultParcelConfig :: ParcelConfig
defaultParcelConfig = ParcelConfig { fpmCommand = Just "fpm", outputType = Nothing }

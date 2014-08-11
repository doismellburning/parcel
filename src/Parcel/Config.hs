module Parcel.Config (
    ParcelConfig
    , defaultParcelConfig
    , fpmCommand
    , merge
    , options
    , outputType
    , outputTypeToFPMString
    , packageName
    , parseOptions
) where

import System.Console.GetOpt

data OutputType = Deb deriving (Enum, Eq, Show)

outputTypeToFPMString :: OutputType -> String
outputTypeToFPMString Deb = "deb"

parseOutputType :: String -> OutputType
-- This is a hack - there must be a way to generate stuff in ArgDescr etc.
-- that produces a nicer, OptParse compatible, error :(
parseOutputType "deb" = Deb
parseOutputType _ = error $ "Invalid output type, must be one of: " ++ (unwords $ map outputTypeToFPMString $ enumFrom Deb)

data ParcelConfig = ParcelConfig
    { fpmCommand :: Maybe FilePath
    , outputType :: Maybe OutputType
    , packageName :: Maybe String
} deriving (Show)

merge :: ParcelConfig -> ParcelConfig -> ParcelConfig
merge a b =
    ParcelConfig
        { fpmCommand = maybeMerge (fpmCommand a) (fpmCommand b)
        , outputType = maybeMerge (outputType a) (outputType b)
        , packageName = maybeMerge (packageName a) (packageName b)
        }

maybeMerge :: Maybe a -> Maybe a -> Maybe a
maybeMerge x Nothing = x
maybeMerge _ (Just x) = Just x

blankParcelConfig :: ParcelConfig
blankParcelConfig = ParcelConfig Nothing Nothing Nothing

defaultParcelConfig :: ParcelConfig
defaultParcelConfig = blankParcelConfig { fpmCommand = Just "fpm" }

options :: [OptDescr (ParcelConfig -> ParcelConfig)]
options =
    [ Option ['f'] ["fpm-command"] (ReqArg (\s c -> c { fpmCommand = Just s }) "COMMAND") "Path to the fpm command to use"
    , Option ['o'] ["output-type"] (ReqArg (\s c -> c { outputType = Just $ parseOutputType s }) "OUTPUT_TYPE") "Output package type"
    , Option ['n'] ["name"] (ReqArg (\s c -> c { packageName = Just s }) "PACKAGE_NAME") "Package name"
    ]

parseOptions :: [String] -> ParcelConfig
parseOptions argv =
    case getOpt RequireOrder options argv of
        (o, [], []) -> foldr id blankParcelConfig o
        (_, _, errors) -> error (concat errors ++ usageInfo header options)

header :: String
header = unlines
    [ "Parcel: Turning code into packages - https://github.com/doismellburning/parcel" -- TODO Stop hardcoding
    ]

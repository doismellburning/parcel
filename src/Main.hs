import Parcel.Config
import Parcel.FPM

import Control.Applicative
import System.Directory
import System.Environment

if' :: Bool -> a -> a -> a
if' True  x _ = x
if' False _ y = y

orgConfigFile = "/etc/parcel.yaml"
packageConfigFile = "./parcel.yaml"

main =
    let
        argv = getArgs

        cliConfig = parseOptions `fmap` argv :: IO ParcelConfig
        orgConfig = fileConfig orgConfigFile :: IO (Maybe ParcelConfig)
        packageConfig = fileConfig packageConfigFile :: IO (Maybe ParcelConfig)

        c = liftA2 applyPackageConfig (return defaultParcelConfig) orgConfig :: IO ParcelConfig
        c2 = liftA2 applyPackageConfig c packageConfig :: IO ParcelConfig
        c3 = liftA2 merge c2 cliConfig
    in
        fpm =<< c3

applyPackageConfig :: ParcelConfig -> Maybe ParcelConfig -> ParcelConfig
applyPackageConfig c mc = maybe c (merge c) mc


fileConfig :: FilePath -> IO (Maybe ParcelConfig)
fileConfig fp =
    let
        isFile = doesFileExist fp :: IO Bool
    in
        isFile >>= \x -> if' x (Just <$> loadYaml fp) (return Nothing) :: IO (Maybe ParcelConfig)

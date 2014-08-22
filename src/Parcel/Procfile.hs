module Parcel.Procfile (
    Proc
    , Procfile
    , loadProcfile
    , parseProcfile
    , procCommand
    , procName
) where

type Procfile = [Proc]

data Proc = Proc
    { procName :: String
    , procCommand :: String
    }

loadProcfile :: FilePath -> IO Procfile
loadProcfile = undefined

parseProcfile :: String -> Procfile
parseProcfile s = map parseProc $ lines s

parseProc :: String -> Proc
parseProc _ = Proc "foo" "bar" -- TODO

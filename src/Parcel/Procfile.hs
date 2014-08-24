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
parseProc s =
    let
        (name, command) = parseProcLine s
    in
        Proc name command

-- Nasty "parser" but I'm on a plane

parseProcLine :: String -> (String, String) -- TODO Bit redundant
parseProcLine s = parseProcLine' s "" ""

parseProcLine' :: String -> String -> String -> (String, String)
parseProcLine' (':':' ':x:xs) name "" = parseProcLine' xs name [x]
parseProcLine' (x:xs) name "" = parseProcLine' xs (name ++ [x]) ""
parseProcLine' (x:xs) name command = parseProcLine' xs name (command ++ [x])
parseProcLine' [] name command = (name, command)

module Parcel.ProcfileSpec where

import Test.Hspec

import Parcel.Procfile

sampleProcLine = "web: gunicorn 0.0.0.0:8080"

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "Parcel" $ do
        it "correctly parses a Proc line name" $ do
            procName (parseProc sampleProcLine) `shouldBe` "web"

        it "correctly parses a Proc command" $ do
            procCommand (parseProc sampleProcLine) `shouldBe` "gunicorn 0.0.0.0:8080"

parseProc :: String -> Proc
parseProc s = head $ parseProcfile $ s

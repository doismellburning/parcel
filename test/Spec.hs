import Test.Hspec

main :: IO ()
main = hspec $ do
    describe "Parcel" $ do
        it "lorem ipsum" $ do
            () `shouldBe` ()

{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Hakocalc.Entity.ProbabilitySpec where


import Control.Exception (evaluate)
import Data.Maybe (fromJust)
import Hakocalc.Entity.Probability
import Test.Hspec


spec = do
  describe "Eq Probability" $
    describe "==" $ do
      it "True" $
        (toProbabilityJust 0.5 == toProbabilityJust 0.5) `shouldBe` True

      it "False" $
        (toProbabilityJust 0.5 == toProbabilityJust 0.1) `shouldBe` False


  describe "Ord Probability" $
    describe "<=" $ do
      it "True 01" $
        (toProbabilityJust 0.5 <= toProbabilityJust 0.9) `shouldBe` True

      it "True 02" $
        (toProbabilityJust 0.5 <= toProbabilityJust 0.5) `shouldBe` True

      it "False" $
        (toProbabilityJust 0.5 <= toProbabilityJust 0.1) `shouldBe` False


  describe "Read Probability" $
    describe "read" $ do
      it "50%" $
        read "50.0" `shouldBe` toProbabilityJust 0.5

      it "75.5%" $
        read "75.5" `shouldBe` toProbabilityJust 0.755

      it "Invalid 01" $
        evaluate (read "Alice" :: Probability) `shouldThrow` anyException

      it "Invalid 02" $
        evaluate (read "50.0%" :: Probability) `shouldThrow` anyException


  describe "Show Probability" $
    describe "show" $ do
      it "50%" $
        show (toProbabilityJust 0.5) `shouldBe` "50.0"

      it "75.5%" $
        show (toProbabilityJust 0.755) `shouldBe` "75.5"


  describe "toProbability" $ do
    it "0%" $
      toProbability 0 `shouldBe` Just (toProbabilityJust 0)

    it "75.5%" $
      toProbability 0.755 `shouldBe` Just (toProbabilityJust 0.755)

    it "100%" $
      toProbability 1 `shouldBe` Just (toProbabilityJust 1)

    it "Over" $
      toProbability 1.25 `shouldBe` Nothing

    it "Under" $
      toProbability (-1) `shouldBe` Nothing


  describe "toProbabilityJust" $ do
    it "0%" $
      toProbabilityJust 0 `shouldBe` fromJust (toProbability 0)

    it "75.5%" $
      toProbabilityJust 0.755 `shouldBe` fromJust (toProbability 0.755)

    it "100%" $
      toProbabilityJust 1 `shouldBe` fromJust (toProbability 1)


  describe "fromProbability" $ do
    it "0%" $
      fromProbability (toProbabilityJust 0) `shouldBe` 0

    it "75.5%" $
      fromProbability (toProbabilityJust 0.755) `shouldBe` 0.755

    it "100%" $
      fromProbability (toProbabilityJust 1) `shouldBe` 1

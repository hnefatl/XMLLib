import Test.Tasty

import XMLTest

main :: IO ()
main = defaultMain testTree

testTree :: TestTree
testTree = testGroup "\nGlobal" [xmlTest]
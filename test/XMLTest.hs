module XMLTest
(
    xmlTest
) where

import XML

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck

xmlTest :: TestTree
xmlTest = testGroup "XMLTest"
    [
        testCase "Attribute Show" $ do
            show $ Attribute "x" "y"
            @=?
            "x=\"y\""
        ,

        testProperty "Attribute Show (QC)" $
            (\lab val -> (show $ Attribute lab val) == (lab ++ "=\"" ++ val ++ "\""))
        ,

        testCase "Pretty print" $ do
            show $
                Element "top" [(Attribute "a" "b")]
                [
                    Element "middle1" [Attribute "foo" "bar", Attribute "bar" "baz"]
                    [
                        Element "bottom1" [] [],
                        Element "bottom2" [Attribute "f" "g"] [],
                        Element "bottom3" [] []
                    ],
                    Element "middle2" [Attribute "x" "y"] []
                ]
            @=?
                "<top a=\"b\">\n\
                \    <middle1 foo=\"bar\" bar=\"baz\">\n\
                \        <bottom1/>\n\
                \        <bottom2 f=\"g\"/>\n\
                \        <bottom3/>\n\
                \    </middle1>\n\
                \    <middle2 x=\"y\"/>\n\
                \</top>\n"
    ]
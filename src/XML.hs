module XML
(
    Attribute(..),
    Element(..)
) where

data Attribute = Attribute
                 {
                    label :: String,
                    value :: String
                 }

instance Show Attribute where
    show a = label a ++ "=\"" ++ value a ++ "\""


data Element = Element
               {
                   tag :: String,
                   attributes :: [Attribute],
                   children :: [Element]
               }

instance Show Element where
    show = unlines . prettyPrint

prettyPrint :: Element -> [String]
prettyPrint e = let attribsPretty  = (concat . map ((" " ++) . show) . attributes) e :: String
                    elementsPretty = (concatMap prettyPrint . children) e :: [String]
                in
                    if null $ children e then
                        ["<" ++ tag e ++ attribsPretty ++ "/>"]
                    else
                        ("<" ++ tag e ++ attribsPretty ++ ">") :
                        map ("    " ++) elementsPretty ++
                        ["</" ++ tag e ++ ">"]
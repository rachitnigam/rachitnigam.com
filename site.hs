--------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}
import           Hakyll

-------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "content/*" $ do
        route   $
          (gsubRoute "content/" (const "")) `composeRoutes`
          setExtension ".html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

module S where
foreign export ccall haskell :: IO ()
haskell :: IO ()
haskell = putStrLn "Sent from Haskell"
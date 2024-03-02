module Main (main) where

import Control.Monad
import Data.Maybe


data MaxStack = MaxStack [Int] deriving (Show)

getMax :: MaxStack -> Int
getMax (MaxStack (y:_)) = y

push :: Int -> MaxStack -> MaxStack
push x (MaxStack ys) = case ys of
  [] -> MaxStack (x:ys)
  (y:ys') -> if x > y then MaxStack (x:ys) else MaxStack (head ys:ys)

pop :: MaxStack -> MaxStack
pop (MaxStack  (_:ys)) = MaxStack  ys

emptyStack :: MaxStack
emptyStack = MaxStack []

processStack :: [String] -> [Int]
processStack [] = []
processStack commands = go emptyStack commands []
    where
        go :: MaxStack -> [String] -> [Int] -> [Int]
        go stack [] maxValues = maxValues
        go stack (x:xs) maxValues =
            let command = head $ words x
            in if command == "push"
                then go (push (read $ last $ words x) stack) xs maxValues
            else if command == "pop"
                then go (pop stack) xs maxValues
            else if command == "max"
                then go stack xs (getMax stack : maxValues)
            else go stack xs maxValues



main :: IO()
main = do
    num <- getLine
    let n = read num :: Int
    commands <- replicateM n $ do
        getLine
    mapM_ print $ reverse $ processStack commands

-- NOT FINISHED --


-- import qualified Data.Sequence as Seq
-- import Data.Maybe (fromJust)
-- import Control.Monad (replicateM)

-- maxSlidingWindow :: Int -> [Int] -> Int -> [Int]
-- maxSlidingWindow n xs m
--     | null xs || m == 0 = []
--     | otherwise = go 0 emptyDeque [] where
--         emptyDeque = Seq.replicate 10 0
--         go _ _ res | length res == n - m + 1 = res
--         go i deque res
--             | i < n = let
--                 deque' = if i >= m && fromJust (Seq.lookup 0 deque) == i - m then Seq.drop 1 deque else deque
--                 deque'' = while (\j -> j < i && xs !! j <= xs !! i) (\j -> Seq.take j deque) deque'
--                 in go (i + 1) (deque' Seq.|> i) $ if i >= m - 1 then res ++ [xs !! fromJust (Seq.lookup 0 deque'')] else res
--             | otherwise = res

-- while :: Ord a => (b -> Bool) -> (b -> b) -> Seq.Seq b -> Seq.Seq b
-- while p f x = if p x then while p f (f x) else x

-- main :: IO ()
-- main = do
--     n <- readLn
--     xs <- replicateM n readLn
--     m <- readLn

--     let result = maxSlidingWindow n xs m
--     mapM_ print result


-- NOT FINISHED --
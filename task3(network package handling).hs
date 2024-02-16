import Control.Monad
import Data.List

processPackets :: Int -> [(Int, Int)] -> [Int]
processPackets size packets = go 0 [] [] []
  where
    go _ [] [] processed | null packets = processed
    go currentTime processor buffer processed | null packets = go (currentTime + 1) processor buffer processed
    go currentTime processor buffer processed =
      case find (\(arrival, duration) -> not (null processor) && fst (head processor) + snd (head processor) == currentTime) processor of
        Just _ -> go (currentTime + 1) (drop 1 processor) buffer (processed ++ [fst (head processor)])
        Nothing ->
          case find (\(arrival, duration) -> arrival == currentTime) packets of
            Just el ->
              if length buffer < size
                then go currentTime (if null processor then [el] else processor ++ [el]) (buffer ++ [fst el]) processed
                else go currentTime ((fst el, -1) : processor) buffer (processed ++ [-1])
            Nothing ->
              case find (\(arrival, duration) -> arrival < currentTime) packets of
                Just el -> go currentTime ((fst el, -1) : processor) buffer (processed ++ [-1])
                Nothing -> go (currentTime + 1) processor buffer processed

readPackets :: Int -> Int -> IO [(Int, Int)]
readPackets size n
  | n <= 0 = return []
  | otherwise = do
    line <- getLine
    let [arrival, duration] = map read $ words line :: [Int]
    rest <- readPackets size (n - 1)
    return ((arrival, duration) : rest)

main = do
    input1 <- getLine
    let [size, n] = map read $ words input1 :: [Int]

    -- Считываем все строки для packets
    packets <- readPackets size n

    let result = processPackets size packets
    mapM_ print result
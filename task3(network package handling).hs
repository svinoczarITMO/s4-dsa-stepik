import Control.Monad

processPackets :: Int -> [(Int, Int)] -> [Int]
processPackets size packets =
    let
        go _ [] _ = []
        go buffer ((arrival, duration):rest) currentTime =
            let
                (bufferTmp, startTimes) = processBuffer buffer arrival currentTime
                startTime = if length bufferTmp < size then max currentTime arrival else -1
            in
                startTime : go bufferTmp rest (max currentTime arrival + duration)

        processBuffer buffer arrival currentTime =
            let
                (valid, rest) = span (\(start, _) -> start <= arrival) buffer
                buffer' = drop (length valid) rest ++ [(currentTime + duration, currentTime + duration) | (_, duration) <- valid]
            in
                (buffer', map fst valid)
    in
        go [] packets 0

main = do
    input1 <- getLine
    let [size, n] = map read $ words input1 :: [Int]

    packets <- replicateM n $ do
        line <- getLine
        let [arrival, duration] = map read $ words line :: [Int]
        return (arrival, duration)

    let result = processPackets size packets
    mapM_ print result
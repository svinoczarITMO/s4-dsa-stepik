import Control.Monad

-- Функция для обработки сетевых пакетов
processPackets :: Int -> Int -> [(Int, Int)] -> [Int]
processPackets size n packets =
    let
        go _ [] _ = []
        go buffer ((arrival, duration):rest) currentTime =
            let
                (buffer', startTimes) = processBuffer buffer arrival currentTime
                startTime = if length buffer' < size then max currentTime arrival else -1
            in
                startTime : go buffer' rest (max currentTime arrival + duration)

        processBuffer buffer arrival currentTime =
            let
                (valid, rest) = span (\(start, _) -> start <= arrival) buffer
                buffer' = drop (length valid) rest ++ [(currentTime + duration, currentTime + duration) | (_, duration) <- valid]
            in
                (buffer', map fst valid)
    in
        go [] packets 0

main = do
    -- Считываем размер буфера и число пакетов
    input1 <- getLine
    let [size, n] = map read $ words input1 :: [Int]

    -- Считываем время поступления и длительность обработки каждого пакета
    packets <- replicateM n $ do
        line <- getLine
        let [arrival, duration] = map read $ words line :: [Int]
        return (arrival, duration)

    -- Выводим ответ
    let result = processPackets size n packets
    mapM_ print result
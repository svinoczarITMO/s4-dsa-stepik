from collections import deque

def processPackets(n: int, buff_size: int, packages: list):
    results = []
    buffer = deque()
    last_processed = 0

    for i in range(n):
        arrival_time, duration = packages[i]

        while buffer and buffer[0][0] <= arrival_time:
            buffer.popleft()

        if len(buffer) < buff_size:
            start_time = arrival_time if not buffer else max(buffer[-1][0], arrival_time)
            results.append(start_time)
            buffer.append((start_time + duration, i))
            last_processed = i
        else:
            results.append(-1)

    return results

def read_packages(nPackages):
    packages = [tuple(map(int, input().split())) for _ in range(nPackages)]
    return packages

def read_input():
    data = input().split()
    size, nPackages = map(int, data)
    return size, nPackages

def main():
    size, nPackages = read_input()

    packages = read_packages(nPackages)

    res = processPackets(nPackages, size, packages)

    for i in res:
        print(i)

if __name__ == "__main__":
    main()
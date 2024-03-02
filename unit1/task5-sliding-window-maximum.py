from collections import deque

def sliding_window_maximum(A, m):
    n = len(A)
    max_values = [0] * (n - m + 1)
    dq = deque()

    for i in range(m):
        while dq and A[dq[-1]] < A[i]:
            dq.pop()
        dq.append(i)

    max_values[0] = A[dq[0]]

    for i in range(1, n - m + 1):
        if dq[0] <= i - 1:
            dq.popleft()

        while dq and A[dq[-1]] < A[i + m - 1]:
            dq.pop()
        dq.append(i + m - 1)

        max_values[i] = A[dq[0]]

    return max_values

n = int(input())
A = list(map(int, input().split()))
m = int(input())

result = sliding_window_maximum(A, m)
print(*result)
import sys

# Working version:
sys.setrecursionlimit(30000)
def get_longest_path_length(elements, current_index):
    current_element = elements[current_index]
    if len(current_element) == 0:
        return 1
    max_length = 1
    for next_index in current_element:
        count = get_longest_path_length(elements, next_index)
        if count > max_length:
            max_length = count
    return 1 + max_length
n = int(input())
list_of_numbers = list(map(int, input().split()))
elements = [[] for _ in range(n)]
for i, nm in enumerate(list_of_numbers):
    if nm != -1:
        elements[nm].append(i)
start_index = list_of_numbers.index(-1)
print(get_longest_path_length(elements, start_index))
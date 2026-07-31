---
tags:
  - LeetCode
  - C++
  - vector
  - 双指针
source: https://docs.qq.com/doc/DZHhydVJEbndyR0ZG
---

# C++ vector 删除与移动零

## 删除末尾元素

```cpp
std::vector<int> values{1, 2, 3, 4};
values.pop_back();  // {1, 2, 3}
```

`pop_back()` 不返回被删除的元素，对空 `vector` 调用会产生未定义行为。

## 删除指定位置元素

```cpp
std::vector<int> values{10, 20, 30, 40};
values.erase(values.begin() + 2);  // {10, 20, 40}
```

删除位置及其后方元素的迭代器和引用会失效。中间删除需要移动后续元素，时间复杂度为 `O(n)`。

## 删除所有指定值：erase-remove 惯用法

```cpp
#include <algorithm>
#include <vector>

std::vector<int> values{1, 3, 5, 3, 7};
values.erase(
    std::remove(values.begin(), values.end(), 3),
    values.end()
);  // {1, 5, 7}
```

`std::remove` 不会改变容器大小，只把保留元素稳定地移动到前方，并返回新的逻辑末尾；`erase` 才真正删除尾部无效区间。

## LeetCode 283：移动零

### 核心思路

使用双指针原地处理：

- `write` 指向下一个非零元素应该写入的位置。
- `read` 从左到右寻找非零元素。
- 遇到非零元素时与 `write` 位置交换，然后递增 `write`。

这样能保持所有非零元素的相对顺序，并把零移动到末尾。

### C++17 代码

```cpp
#include <utility>
#include <vector>

using std::vector;

class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        int write = 0;

        for (int read = 0; read < static_cast<int>(nums.size()); ++read) {
            if (nums[read] != 0) {
                if (write != read) {
                    std::swap(nums[write], nums[read]);
                }
                ++write;
            }
        }
    }
};
```

### 复杂度

- 时间复杂度：`O(n)`。
- 空间复杂度：`O(1)`。

### 易错点

- 必须保持非零元素的相对顺序。
- 不要反复调用 `erase` 删除零，否则最坏可能退化为 `O(n²)`。
- `std::remove` 不能单独缩短 `vector`。
- 如果采用覆盖写法，写完非零元素后还要显式把剩余位置填零。

## 相关笔记

- [[LeetCode 索引]]

## 来源

- [腾讯文档：LeetCode](https://docs.qq.com/doc/DZHhydVJEbndyR0ZG)

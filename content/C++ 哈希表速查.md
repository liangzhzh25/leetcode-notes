---
tags:
  - C++
  - 哈希表
source: https://docs.qq.com/doc/DZHhydVJEbndyR0ZG
---

# C++ 哈希表速查

## 基本声明

```cpp
#include <iostream>
#include <string>
#include <unordered_map>

int main() {
    std::unordered_map<int, std::string> nameById;

    nameById[1001] = "张三";
    nameById[1002] = "李四";
    nameById[1003] = "王五";

    std::cout << nameById.at(1002) << '\n';
}
```

`unordered_map<Key, Value>` 保存键值对，平均查询、插入和删除复杂度为 `O(1)`，最坏为 `O(n)`。

## 查询键是否存在

```cpp
const auto it = nameById.find(1002);
if (it != nameById.end()) {
    std::cout << it->second << '\n';
}
```

## 常用访问方式

| 写法 | 键不存在时的行为 | 适用场景 |
|---|---|---|
| `table[key]` | 插入一个默认值 | 明确需要新增或更新 |
| `table.at(key)` | 抛出 `std::out_of_range` | 确信键存在 |
| `table.find(key)` | 返回 `end()` | 只查询、不希望意外插入 |

## 在“两数之和”中的用法

哈希表保存“已经遍历过的数值 → 下标”。每轮应先查补数，再保存当前元素：

```cpp
const int need = target - nums[i];
const auto it = indexByValue.find(need);
if (it != indexByValue.end()) {
    return {it->second, i};
}
indexByValue[nums[i]] = i;
```

## 易错点

- 使用 `table[key]` 查询可能意外插入新键。
- `unordered_map` 不保证遍历顺序。
- 自定义键类型需要提供相等比较和哈希函数。
- 平均 `O(1)` 不代表所有情况下都严格为常数时间。

## 相关笔记

- [[1. 两数之和]]
- [[LeetCode 索引]]

## 来源

- [腾讯文档：LeetCode](https://docs.qq.com/doc/DZHhydVJEbndyR0ZG)

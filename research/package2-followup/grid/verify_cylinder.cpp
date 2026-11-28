// Exact-length shortest walks for integer {2}-domination on P_5 x C_n.
// Compile with a C++17 compiler. No external files, libraries or solver.
#include <algorithm>
#include <array>
#include <cstdint>
#include <iostream>
#include <map>
#include <numeric>
#include <stdexcept>
#include <string>
#include <vector>

using Column = std::array<int, 5>;
using Distance = std::uint16_t;
constexpr int columns = 243;
constexpr Distance infinity = 10000;  // finite length-70 weights are at most 700

Column decode(int index) {
    Column c{};
    for (int row = 4; row >= 0; --row) {
        c[row] = index % 3;
        index /= 3;
    }
    return c;
}

Column deficit(const Column& left, const Column& middle) {
    Column need{};
    for (int i = 0; i < 5; ++i) {
        int sum = left[i] + middle[i];
        if (i > 0) sum += middle[i - 1];
        if (i < 4) sum += middle[i + 1];
        need[i] = std::max(0, 2 - sum);
    }
    return need;
}

int claimed_minimum(int n) {
    static const std::array<int, 6> excess{3, 6, 9, 10, 13, 19};
    bool correction = std::find(excess.begin(), excess.end(), n % 20) != excess.end();
    return (23 * n + 9) / 10 + correction - (n == 6 || n == 9);
}

int main() {
    std::array<Column, columns> column;
    std::array<int, columns> weight;
    for (int c = 0; c < columns; ++c) {
        column[c] = decode(c);
        weight[c] = std::accumulate(column[c].begin(), column[c].end(), 0);
    }

    std::vector<int> middle;
    std::vector<Column> need;
    std::vector<int> pair_to_state(columns * columns);
    for (int b = 0; b < columns; ++b) {
        std::map<Column, int> ids;
        for (int a = 0; a < columns; ++a) {
            Column d = deficit(column[a], column[b]);
            auto [it, created] = ids.emplace(d, static_cast<int>(middle.size()));
            if (created) {
                middle.push_back(b);
                need.push_back(d);
            }
            pair_to_state[a * columns + b] = it->second;
        }
    }

    const int states = static_cast<int>(middle.size());
    std::vector<std::vector<int>> predecessors(states);
    int edges = 0;
    for (int s = 0; s < states; ++s) {
        for (int c = 0; c < columns; ++c) {
            bool fits = true;
            for (int i = 0; i < 5; ++i)
                if (column[c][i] < need[s][i]) fits = false;
            if (fits) {
                predecessors[pair_to_state[middle[s] * columns + c]].push_back(s);
                ++edges;
            }
        }
    }
    if (states != 1595 || edges != 161572)
        throw std::runtime_error("unexpected transfer graph size");

    // The row index is the endpoint, the column index is the start.
    const int cells = states * states;
    std::vector<Distance> walks(cells, infinity), next(cells), length50;
    for (int s = 0; s < states; ++s) walks[s * states + s] = 0;
    for (int n = 1; n <= 70; ++n) {
        for (int t = 0; t < states; ++t) {
            Distance* row = next.data() + t * states;
            std::fill_n(row, states, infinity);
            for (int s : predecessors[t]) {
                const Distance* previous = walks.data() + s * states;
                for (int start = 0; start < states; ++start)
                    row[start] = std::min(row[start], previous[start]);
            }
            for (int start = 0; start < states; ++start)
                row[start] = std::min<int>(infinity, row[start] + weight[middle[t]]);
        }
        next.swap(walks);
        if (n >= 3) {
            Distance best = infinity;
            for (int i = 0; i < states; ++i) best = std::min(best, walks[i * states + i]);
            if (best != claimed_minimum(n))
                throw std::runtime_error("incorrect proposed value at n=" + std::to_string(n));
        }
        if (n == 50) length50 = walks;
    }
    for (int i = 0; i < cells; ++i)
        if (walks[i] == infinity || length50[i] == infinity || walks[i] != length50[i] + 46)
            throw std::runtime_error("length-50 to length-70 matrix identity failed");
    std::cout << states << " states, " << edges << " directed edges\n"
              << "All diagonal minima match for n=3,...,70.\n"
              << "D70 = D50 + 46 in all " << cells << " coordinates.\n";
}

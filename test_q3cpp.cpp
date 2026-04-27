// Single line comment
/* Block comment */

/** This won't appear — no javadoc here */

#include <iostream>
#include <vector>

namespace MyNS {

template<typename T>
class Stack {
private:
    std::vector<T> data;
    int size;

public:
    Stack() : size(0) {}
    virtual ~Stack() {}

    void push(T item) {
        data.push_back(item);
        ++size;
    }

    T pop() {
        if (size == 0) throw "empty";
        --size;
        return data[size];
    }

    bool isEmpty() const { return size == 0; }
};

} // namespace MyNS

int main() {
    MyNS::Stack<int> s;
    s.push(0xFF);
    s.push(0b1010);   /* not valid C++ literal but tests UNKNOWN */
    s.push(3.14f);
    s.push(1e10);

    int x = 10, y = 20;
    int z = x >= y ? x : y;
    int w = (x << 2) | (y >> 1);
    bool flag = (x == y) || (x != 0) && !(y <= 0);

    int *p = &x;
    int Stack<int>::*mp = nullptr;

    const_cast<int&>(x) = 5;
    static_cast<double>(y);

    std::cout << "result: " << z << std::endl;
    return 0;
}

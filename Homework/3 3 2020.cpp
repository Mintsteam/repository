/*
	功能：求最大公约数的三种算法 
	参考文献：第一章PPT
	参考页码：P11-15
	编译环境：Visual Studio Code 1.42.1 / Windows 10 1909
	编辑日期：2020年3月3日
	调试实现：张浩东
	编码：UTF-8
*/
#include <iostream>
#include <math.h>
using namespace std;
int Euclid(int m, int n)
{
    int x;
    while (n != 0)
    {
        x = m % n;
        m = n;
        n = x;
    }

    return m;
}
int GCDUsingRecursion(int m, int n)
{
    if (n != 0)
        GCDUsingRecursion(n, m % n);
    else
        return m;
}
int GCDUsingBruteForce(int m, int n)
{
    int smaller, j, result;
    if (m <= n)
    {
        smaller = m;
    }
    else
    {
        smaller = n;
    }
    j = smaller;
    for (int i = 0; i < smaller; i++)
    {
        if (m % j == 0 && n % j == 0)
        {
            result = j;
        }
        else
        {
            j--;
        }
    }
    return result;
}
int main()
{
    int x, y;
    cout << "please input two numbers separated by whitespace:" << endl;
    cin >> x >> y;
    cout << "GCDUsingRecursion:  " << GCDUsingRecursion(x, y) << endl;
    cout << "GCDUsingBruteForce: " << GCDUsingBruteForce(x, y) << endl;
    cout << "GCDUsingEuclid:     " << Euclid(x, y) << endl;
    system("pause");
    return 0;
}
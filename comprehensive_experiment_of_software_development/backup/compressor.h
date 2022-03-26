#ifndef COMPRESSOR_H
#define COMPRESSOR_H
#include <iostream>
#include <fstream>
#include <queue>
#include <map>
#include <vector>
#include <bitset>
#include <QFileInfo>
#include <QDebug>
#include "md5.h"
using namespace std;
class Compressor
{
    map<unsigned char, string> codeMap;
    struct haffNode{
        unsigned long long freq;//待编码字符频率
        unsigned char uchar;//待编码字符
        string code;//编码后的二进制串
        struct haffNode* left = 0;//哈夫曼节点左孩子
        struct haffNode* right = 0;//哈夫曼节店右孩子
    };
    struct Compare{
        bool operator ()(const haffNode* a, const haffNode* b) {
            return a->freq > b->freq;
        }};
    void encode(haffNode* pn, string code);
public:
    Compressor();
    int compress(string sourcePath, string destinationPath, string pw);
};

#endif // COMPRESSOR_H

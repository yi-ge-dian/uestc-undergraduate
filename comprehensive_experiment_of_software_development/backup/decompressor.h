#ifndef DECOMPRESSOR_H
#define DECOMPRESSOR_H
#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <bitset>
#include <cstring>
#include <queue>
#include <QFileInfo>
#include <QDebug>
#include "md5.h"
using namespace std;
class Decompressor
{

map<unsigned char, string> codeMap;
struct haffNode {
    unsigned long long freq;
    unsigned char uchar;
    string code;
    struct haffNode* left = 0;
    struct haffNode* right = 0;
};

struct compare {
    bool operator ()(const haffNode* a, const haffNode* b) {
        return a->freq > b->freq;
    }
};
void insert_node(haffNode* father, unsigned char uchar, string code);
public:
    Decompressor();
    int decompress(string sourcePath, string destinationPath, string pw);
};

#endif // DECOMPRESSOR_H

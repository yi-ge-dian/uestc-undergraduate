#ifndef UTILS_H
#define UTILS_H
#include "windows.h"
#include "stdio.h"

static char* dwordToCharArray(DWORD dwTime){
    char* out=new char[12]{'\0'};
    sprintf(out,"%11ul",dwTime);
    return out;
}
static DWORD charArrayToDword(char* out){
    DWORD dwTime;
    sscanf(out,"%11ul",&dwTime);
    return dwTime;
}

#endif // UTILS_H

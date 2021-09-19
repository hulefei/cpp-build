//max_cpp.cpp
int max(int x, int y){
  return x >= y ? x : y;
}

// extern C call
extern "C" {
  int maxii(int x,int y){
    return max(x,y);
  }
}
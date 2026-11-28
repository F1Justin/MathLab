// Independent direct transition enumeration. No suffix-minimum optimization.
// Recomputes full state vectors, checks supplied vectors and exact periodicity,
// and independently brute-forces actual grid labelings for very small widths.
#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

using namespace std;
constexpr int INF=1000000000;

int main(int argc, char **argv) {
    if(argc!=8) { cerr << "m k N p inc start.txt end.txt\n"; return 2; }
    int m=stoi(argv[1]), k=stoi(argv[2]), N=stoi(argv[3]);
    int p=stoi(argv[4]), inc=stoi(argv[5]), q=1;
    for(int i=0;i<m;i++) q*=k+1;
    vector<vector<int>> col(q,vector<int>(m));
    vector<int> weight(q);
    for(int x=0;x<q;x++) {
        int z=x;
        for(int i=m-1;i>=0;i--) { col[x][i]=z%(k+1); z/=k+1; }
        for(int v:col[x]) weight[x]+=v;
    }
    auto valid=[&](int a,int b,int c) {
        for(int i=0;i<m;i++) {
            int s=col[a][i]+col[b][i]+col[c][i];
            if(i>0) s+=col[b][i-1];
            if(i+1<m) s+=col[b][i+1];
            if(s<k) return false;
        }
        return true;
    };
    vector<vector<int>> pred(q*q);
    long long edge_count=0;
    for(int b=0;b<q;b++) for(int c=0;c<q;c++)
        for(int a=0;a<q;a++) if(valid(a,b,c)) {
            pred[b*q+c].push_back(a*q+b); edge_count++;
        }
    vector<int> d(q*q,INF), next(q*q,INF), anchor;
    for(int b=0;b<q;b++) d[b]=weight[b];
    vector<int> optimum(N+p+1);
    for(int n=1;n<=N+p;n++) {
        int best=INF;
        for(int a=0;a<q;a++) for(int b=0;b<q;b++)
            if(valid(a,b,0)) best=min(best,d[a*q+b]);
        optimum[n]=best;
        if(m==3 && k==3) assert(best==(11*n+8)/5);
        if(m==5 && k==2) {
            const vector<int> exceptional={2,3,5,6,8,9,12,15,18};
            int expected=(23*n+26)/10;
            if(find(exceptional.begin(),exceptional.end(),n)!=exceptional.end()) --expected;
            assert(best==expected);
        }
        if(n==N) anchor=d;
        if(n==N || n==N+p) {
            ifstream f(argv[n==N ? 6 : 7]);
            assert(f.good());
            for(int idx=0;idx<q*q;idx++) { int v; assert(bool(f>>v)); assert(v==d[idx]); }
            int extra; assert(!(f>>extra));
        }
        if(n==N+p) {
            for(int idx=0;idx<q*q;idx++) { assert(anchor[idx]<INF); assert(d[idx]==anchor[idx]+inc); }
            break;
        }
        for(int state=0;state<q*q;state++) {
            int z=INF;
            for(int prev:pred[state]) z=min(z,d[prev]);
            next[state]=z==INF ? INF : z+weight[state%q];
        }
        d.swap(next);
    }
    // Brute force uses vertices and direct closed neighborhoods, independent of
    // the transfer feasibility predicate. This also audits boundary conventions.
    for(int width=1;width<=3 && m*width<=10;width++) {
        int vertices=m*width, total=1;
        for(int v=0;v<vertices;v++) total*=k+1;
        int best=INF;
        vector<int> values(vertices);
        for(int x=0;x<total;x++) {
            int z=x, cost=0;
            for(int v=0;v<vertices;v++) { values[v]=z%(k+1); z/=k+1; cost+=values[v]; }
            if(cost>=best) continue;
            bool ok=true;
            for(int r=0;r<m && ok;r++) for(int c=0;c<width;c++) {
                int sum=values[r*width+c];
                if(r>0) sum+=values[(r-1)*width+c];
                if(r+1<m) sum+=values[(r+1)*width+c];
                if(c>0) sum+=values[r*width+c-1];
                if(c+1<width) sum+=values[r*width+c+1];
                if(sum<k) { ok=false; break; }
            }
            if(ok) best=cost;
        }
        assert(best==optimum[width]);
        cout << "bruteforce width="<<width<<" assignments="<<total<<" min="<<best<<" PASS\n";
    }
    cout<<"ALL_PASS m="<<m<<" k="<<k<<" states="<<q*q
        <<" transitions="<<edge_count<<" V"<<N+p<<"=V"<<N<<"+"<<inc<<"\n";
    cout<<"FORMULA_BASE_CASES_PASS through="<<N+p<<"\n";
}

#define I int
#define T double

/* template <class I, class T> */
void csr_matvec(const I n_row,
                const I n_col,
                const I Ap[],
                const I Aj[],
                const T Ax[],
                const T Xx[],
                      T Yx[])
{
    for(I i = 0; i < n_row; i++){
        T sum = Yx[i];
        for(I jj = Ap[i]; jj < Ap[i+1]; jj++){
            sum += Ax[jj] * Xx[Aj[jj]];
        }
        Yx[i] = sum;
    }
}

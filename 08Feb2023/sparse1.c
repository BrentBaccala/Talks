
double sum;

const int Aj[4];
const double Ax[4];
const double Xx[4];

void vecmult(void)
{
    for(int jj = 0; jj < 4; jj++){
        sum += Ax[jj] * Xx[Aj[jj]];
    }
}

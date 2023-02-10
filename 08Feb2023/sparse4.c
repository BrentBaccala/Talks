
double tmp1[4] __attribute__((aligned(32)));
double tmp2[4] __attribute__((aligned(32)));
double tmp3[4] __attribute__((aligned(32)));

void vecmult(void)
{
    for (int i=0; i<4; i++) {
	tmp3[i] += tmp1[i] * tmp2[i];
    }
}

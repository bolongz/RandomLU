A= randn(10, 10);
whos A
[B, ~] = GenerateMatrixTest(A, 10, 10, 10, 1);
whos A
whos B

C = A * B;

whos A
whos B

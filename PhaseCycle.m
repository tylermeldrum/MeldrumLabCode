clear

delP = [2	-4	4	-3;
    2	-4	3	-2;
    2	-4	2	-1;
    2	-4	1	0;
    2	-4	0	1;
    1	-2	3	-3;
    1	-2	2	-2;
    1	-2	1	-1;
    1	-2	0	0;
    1	-2	-1	1;
    0	0	2	-3;
    0	0	1	-2;
    0	0	0	-1;
    0	0	-1	0;
    0	0	-2	1;
    -1	2	1	-3;
    -1	2	0	-2;
    -1	2	-1	-1;
    -1	2	-2	0;
    -1	2	-3	1;
    -2	4	0	-3;
    -2	4	-1	-2;
    -2	4	-2	-1;
    -2	4	-3	0;
    -2	4	-4	1];

phase = [0	0	0	0;
        0	0	1	2;
        0	0	2	0;
        0	0	3	2;
        1   0   1   0;
        1   0   2   2;
        1   0   3   0;
        1   0   0   2;
        2   0   2   0;
        2   0   3   2;
        2   0   0   0;
        2   0   1   2;
        3   0   3   0;   
        3   0   0   2;
        3   0   1   0;
        3   0   2   2];

for i = 1:size(delP,1);
    for j = 1:size(phase,1)
    recphase(j,i) = -delP(i,1)*phase(j,1) +  -delP(i,2)*phase(j,2) + -delP(i,3)*phase(j,3) + -delP(i,4)*phase(j,4);
    end
end
recphase = mod(recphase,4);

function pathIncreases = createLettersPoints(letterLength,letterSpacing)
ll = letterLength;
ls = letterSpacing;
pathIncreases = [
    0       0           0;
    0       -ll         0;
    0       0           -ll;
    0       ll*3/4      0;
    0   	-3/4*ll     0;
    0       0           -ll  
    0       ll+ll/ls    0;
    0       ll/2        2*ll;
    0       ll/2        -2*ll;
    0       ls          0;
    0       0           2*ll;
    0       ll          -2*ll;
    0       0           2*ll;
    0       0           -2*ll;
    0       ls          0;
    0       0           2*ll;
    0       0           -2*ll;
    0       ll          0;
    0       0           2*ll;
    0       0           -2*ll;
    0       ls          0;
    0       ll          0;
    0       -ll         0;
    0       0           2*ll;
    0       ll          0
];
end


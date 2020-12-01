clc;
close all;
tic

% -------------  Dataset tai12.dat ----------------- %
distance=[
  0 27 85  2  1 15 11 35 11 20 21 61
 27  0 80 58 21 76  72 44 85 94 90 51
 85 80  0  3 48 29 90 66 41 15 83 96
  2 58  3  0 74 45 65 40 54 83 14 71
  1 21 48 74  0 77 36 53 37 26 87 76
 15 76 29 45 77  0 91 13 29 11 77 32
 11 72 90 65 36 91  0 87 67 94 79  2
 35 44 66 40 53 13 87  0 10 99 56 70
 11 85 41 54 37 29 67 10  0 99 60  4
 20 94 15 83 26 11 94 99 99  0 56  2
 21 90 83 14 87 77 79 56 60 56  0 60
 61 51 96 71 76 32  2 70  4  2 60  0
        ];
    
 flow=[
  0 21 95 82 56 41  6 25 10  4 63  6
 21  0 44 40 75 79  0 89 35  9  1 85
 95 44  0 84 12  0 26 91 11 35 82 26
 82 40 84  0 69 56 86 45 91 59 18 76
 56 75 12 69  0 39 18 57 36 61 36 21
 41 79  0 56 39  0 71 11 29 82 82  6
  6  0 26 86 18 71  0 71  8 77 74 30
 25 89 91 45 57 11 71  0 89 76 76 40
 10 35 11 91 36 29  8 89  0 93 56  1
  4  9 35 59 61 82 77 76 93  0 50  4
 63  1 82 18 36 82 74 76 56 50  0 36
  6 85 26 76 21  6 30 40  1  4 36  0
        ];

% -------------  Dataset tai17.dat ----------------- %

%  distance = [  0 20 86  4 77 15 89 48 14 89 44 59 22 57 63  6  0
%  20  0 62 41 62 46 25 75 76 40 66 58 30 68 78 91 13
%  86 62  0 59 49 85 84  8 38 41 56 39 53 77 50 30 58
%   4 41 59  0 55 19 85 52 34 53 40 69 12 85 72  7 49
%  77 62 49 55  0 46 87 58 17 68 27 21  6 67 26 82 44
%  15 46 85 19 46  0 35  3 62  8 51  1 91 39 87 72 45
%  89 25 84 85 87 35  0 96  7 87 68 33  3 21 90 45 47
%  48 75  8 52 58  3 96  0 25 30 43 97 33 35 61 42 36
%  14 76 38 34 17 62  7 25  0 43  7 84  6  0  0 48 62
%  89 40 41 53 68  8 87 30 43  0 59 29 94 82 29  3  3
%  44 66 56 40 27 51 68 43  7 59  0 51 67 39 15 66 42
%  59 58 39 69 21  1 33 97 84 29 51  0 23 62 62 28 76
%  22 30 53 12  6 91  3 33  6 94 67 23  0 66 82 98 35
%  57 68 77 85 67 39 21 35  0 82 39 62 66  0 15 17 77
%  63 78 50 72 26 87 90 61  0 29 15 62 82 15  0 44 26
%   6 91 30  7 82 72 45 42 48  3 66 28 98 17 44  0 76
%   0 13 58 49 44 45 47 36 62  3 42 76 35 77 26 76  0];


% flow=[
%       0 21 95 82 56 41  6 25 10  4 63  6 44 40 75 79  0
%  21  0 89 35  9  1 85 84 12  0 26 91 11 35 82 26 69
%  95 89  0 56 86 45 91 59 18 76 39 18 57 36 61 36 21
%  82 35 56  0 71 11 29 82 82  6 71  8 77 74 30 89 76
%  56  9 86 71  0 76 40 93 56  1 50  4 36 27 85  2  1
%  41  1 45 11 76  0 15 11 35 11 20 21 61 80 58 21 76
%   6 85 91 29 40 15  0 72 44 85 94 90 51  3 48 29 90
%  25 84 59 82 93 11 72  0 66 41 15 83 96 74 45 65 40
%  10 12 18 82 56 35 44 66  0 54 83 14 71 77 36 53 37
%   4  0 76  6  1 11 85 41 54  0 26 87 76 91 13 29 11
%  63 26 39 71 50 20 94 15 83 26  0 77 32 87 67 94 79
%   6 91 18  8  4 21 90 83 14 87 77  0  2 10 99 56 70
%  44 11 57 77 36 61 51 96 71 76 32  2  0 99 60  4 56
%  40 35 36 74 27 80  3 74 77 91 87 10 99  0  2 60 72
%  75 82 61 30 85 58 48 45 36 13 67 99 60  2  0 74 46
%  79 26 36 89  2 21 29 65 53 29 94 56  4 60 74  0 13
%   0 69 21 76  1 76 90 40 37 11 79 70 56 72 46 13  0
%     ];


 n=size(distance,1);
 StartingSolution=[12 6 4 9 11 8 10 7 2 3 5 1]; %randperm(n) % Random Permutation
 iterationNumber = 1;

current = BestLocalSearch(StartingSolution,n,distance,flow)

while(iterationNumber < 1000)

iterationNumber = iterationNumber + 1;
s = perturbation(current, n);
sprime = BestLocalSearch(s,n,distance,flow)
    if(CalculateCost(sprime,n,distance,flow) < CalculateCost(current,n,distance,flow))
        current = sprime
    end
end


disp("Best Solution cost ");
costofCurrent = CalculateCost(current,n,distance,flow);
disp(costofCurrent);
disp("Iteration Number")
disp(iterationNumber);




	
%Best Local Search Function
function solution = BestLocalSearch(s,n,distance,flow)
    z=CalculateCost(s,n,distance,flow);
    solution=s;
    solutioncost=z;
    while(1)
        for i=1:n-3
            j=i+2;
            while j<=n
                solutionprime=s;
                temp1=solutionprime(i+1);
                solutionprime(i+1)=solutionprime(j);
                solutionprime(j)=temp1;
                solutioncostprime=CalculateCost(solutionprime,n,distance,flow);
                if (solutioncostprime >= solutioncost && j<n)
                    j=j+2;
                else
                    j=j+2;
                    if(solutioncostprime<solutioncost)
                        solution=solutionprime;
                        solutioncost=solutioncostprime;
                    end
                end
                
                
            end
        end
        if s == solution
            break
        else
            s=solution;
            z=solutioncost;
        end
    end
end
	
%Fitness Function
function z = CalculateCost(sol,n,distance,flow)
    z=0;
       for i=1:n
           for j=1:n
               z=z+distance(i,j)*flow(sol(i),sol(j));
           end
       end
end

% Perturbation with Swap of 3 elements
function newSol = perturbation(sol,n)
newSol = sol;
    for i=1:3
        randomIndex1=randi([1,n]);
        randomIndex2=randi([1,n]);
        temp = newSol(randomIndex1);
        newSol(randomIndex1) = newSol(randomIndex2)
        newSol(randomIndex2) = temp;
    end
end
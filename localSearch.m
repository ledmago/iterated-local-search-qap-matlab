clc;
close all;
tic


distance=[
  0 27 85  2  1 15 11 35 11 20 21 61
 27  0 80 58 21 76 72 44 85 94 90 51
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


% TODO : data olarak diğerini de ekle, first local searchu de ekle

 n=size(distance,1);
 StartingSolution=[12 6 4 9 11 8 10 7 2 3 5 1]; %randperm(n) % Random Permutation
 iterationNumber = 1;

current = BestLocalSearch(StartingSolution,n,distance,flow)

while(iterationNumber < 500)

iterationNumber = iterationNumber + 1;
s = perturbation(current, n);
sprime = BestLocalSearch(s,n,distance,flow)
    if(CalculateCost(sprime,n,distance,flow) < CalculateCost(current,n,distance,flow))
        current = sprime
    end
end
end


printf("Best Solution cost %d, Iteration = %d", CalculateCost(current,n,distance,flow), iterationNumber)
current


	
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

function newSol = perturbation(sol,n)
newSol = sol;
    for i=1:2
        randomIndex1=randi([1,n]);
        randomIndex2=randi([1,n]);
        temp = newSol(randomIndex1);
        newSol(randomIndex1) = newSol(randomIndex2)
        newSol(randomIndex2) = temp;
    end
end



// Best Solution cost 224416, Iteration = 115current =

 //   8    1    6    2   11   10    3    5    9    7   12    4

//  def perturbation(self):
//     k = rd.randint(2, self.data.n) // 2 ie n arası random sayı
//     indexes = np.random.choice(np.arange(self.data.n), k, replace=False)
//     shuffled_indexes = np.random.permutation(indexes)
//     new_solution = self.solution.copy()
//     new_solution[indexes] = self.solution[shuffled_indexes]
//     return new_solution


// https://github.com/Lolik-Bolik/Quadratic_Assign_Problem/blob/master/algorithms/iterated_local_search.py
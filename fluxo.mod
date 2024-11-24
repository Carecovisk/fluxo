
# Parâmetros
param n, integer, > 2; # Nûmero de nós
param O, integer, default 1; # Nó de origem
param T, integer, default n; # Nó destino.

set V := {1..n}; # Conjunto de nós
set E, within V cross V; # Conjunto de arestas. Precisa estar contido no produto cartesiano de V por V


param fluxo_max{(i, j) in E};
param fluxo_min{(i, j) in E}, default 0;

# Variaveis de decisão
var x{(i, j) in E}, >= 0;

# Função objetivo
maximize obj: sum{(O, j) in E} x[O, j];

s.t. r1:
    sum{(k, T) in E} x[k, T] - sum{(O, j) in E} x[O, j] = 0; # Conservação dos fluxos nos nós de origem e destino
s.t. r2{i in V : i != O and i != T}:
    sum{(k, i) in E} x[k, i] - sum{(i, j) in E} x[i, j] = 0; # Conservação dos fluxos nos nós intermediarios.
s.t. r3{(i,j) in E}:
    fluxo_min[i, j] <= x[i, j] <= fluxo_max[i, j]; # Garantir fluxo minimo e maximo em cada arco.
s.t. r4{(i, j) in E}:
    x[i, j] >= 0; #Garantir não negatividade


solve;
# printf{(i, j) in E} "---> (%g, %g): %g\n", i, j, fluxo_max[i, j];
printf "----------\n";
printf "Resultado da função objetivo: %g\n", obj;
printf{(i, j) in E} "E(%g, %g) = %g\n", i, j, x[i, j];

data;

param n := 4; # Nûmero de nós

param : E : fluxo_max := # Formato para definir fluxo maximo em uma aresta: index_i index_j valor_do_fluxo
        1 2 10
        1 3 20
        3 2 5
        3 4 10
        2 4 15;
end;

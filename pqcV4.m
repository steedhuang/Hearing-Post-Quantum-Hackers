% Created 2022-09-20
% Authors: ZH Wang, HC Lin, JS Huang
% Analysis of PQC Toy Example of CINVESTAV: 4th within research centers 
% in Latin America which holds the position 118 in the world
% This code shows how a Isomorphic graphs polynomials are hacked
clc;
clear;
clf;
% consider the graph G = (U, D), where U = 1, 2, 3, 4 ... N, and D = f(1, 2), (2, 3), (3, 4), (N, 1). 

% Data pattern to be tested like Prime, Natural, Fibonacci, Recaman: 
% even or odd whatever you like hearing ... http://oeis.org/   
sequences = readtable('sequences.xlsx','ReadVariableNames',1);
Names = ['P';'N';'F';'R'];

% Total cases
N=360
% Total trials for each case
T=200

for j=1:4
    M=sequences.(j)
    for n=1:N
      count=0;
      TT=round(T*n)
      for i=1:TT
     % Consider the halfway permutation beween 1 and N
      P1=round(1+(M(n)/2)*rand);
      P2=round(M(n)/2+(M(n)/2)*rand);
     % Edge P1 and Edge P2 will be removed from G and added into H 
      H1=round(1+(M(n)/2)*rand);
      H2=round(M(n)/2+(M(n)/2)*rand);
     % Check if hack simulation success
      if H1==P1&&H2==P2
          count=count+1;
      end
      % Changing bottom floor probability: 2 out of TT combination: 1/2~1/4
      if count==0
          bottom=0.3333/TT^2; % lower bound
      else    
          bottom=count/TT; % higher bound
      end
      P(n)=bottom;
    end
    end
% The diagrams of infite k-covariance
    figure(j)
% Original data
    plot(log(P));
    hold on;
    plot(log(movmean(P,16))); % a level of 16 cases
    hold off;
    legend('mean','smoothed')
    SequenName = strcat(Names(j),' Hacked Probability vs Permutation Length Index')
    title(SequenName)
    xlabel('Length Index')
    ylabel('Chance of Broken')
end
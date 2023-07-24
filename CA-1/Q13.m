%% Q13
%% Generating 10,000 sampels for X
TS = [0.7 0.7 0.7; 
      0.29 0.29 0.29; 
      0.01 0.01 0.01]';
  
P = [7/10 29/100 1/100];

% determining the first state
FS = sum(rand >= cumsum([0, P(1), P(2), P(3)])); %First State
state = FS;
sampels = cell(1,10000);
for i = 1:10000
        NS = sum(rand >= cumsum([0, TS(state,1), TS(state,2), TS(state,3)])) ;
        if NS == 1
            sampels{i} = 'A';
        elseif NS == 2
            sampels{i} = 'B';
        else
            sampels{i} = 'C';
        end
        state=NS;
end
%% Calculating Gk for k = 1,2,...,10
transition_states = [0.7 0.7 0.7; 
                     0.29 0.29 0.29; 
                     0.01 0.01 0.01]';
Gk = zeros(10,1);
for i =1:10
    Gk(i) = entropy(i,transition_states);
end
figure(1)
plot(Gk,'m','LineWidth',2)
xlabel('k','Interpreter','latex')
%% Calculating Huffman avrage length
AverageLength = zeros(1,10);
for k = 1:10
    AverageLength(k) = average_length(sampels,k);
end
figure(1)
hold on
plot(AverageLength,'c','LineWidth',2)
%% Code Efficiency 
H = (1:10).^(-1).*AverageLength;
H_X = 0.9445;
Code_Eff = H_X./H;
figure(1)
hold on
plot(Code_Eff,'g','LineWidth',2)
plot(ones(1,10)*H_X,'r','LineWidth',2)
legend('Gk','Average Length','Code Efficiency','Entropy')
%% Generating 10,000 sampels for X^2
TS = [ones(1,9)*0.49; % aa
      ones(1,9)*0.0841; %bb
      ones(1,9)*0.0001; %cc
      ones(1,9)*0.203; %ab
      ones(1,9)*0.007; %ac
      ones(1,9)*0.0029; %bc
      ones(1,9)*0.203; %ba
      ones(1,9)*0.007;%ca
      ones(1,9)*0.0029;]'; %cb
P =[0.49 0.0841 0.0001 0.203 0.007 0.0029 0.203 0.007 0.0029];
% determining the first state
FS = sum(rand >= cumsum([0, P])); %First State
state = FS;
sampels = cell(1,10000);
for i = 1:10000
        NS = sum(rand >= cumsum([0, TS(state,:)])) ;
        if NS == 1
            sampels{i} = 'AA';
        elseif NS == 2
            sampels{i} = 'BB';
        elseif NS == 3
            sampels{i} = 'CC';
        elseif NS == 4
            sampels{i} = 'AB';
        elseif NS == 5
            sampels{i} = 'AC'; 
        elseif NS == 6
            sampels{i} = 'BC';
        elseif NS == 7
            sampels{i} = 'BA';
        elseif NS == 8
            sampels{i} = 'CA';
        elseif NS == 9
            sampels{i} = 'CB';
        end
        state=NS;
end
%% Calculating Gk for k = 1,2,...,10
transition_states = TS;
Gk = zeros(10,1);
for i =1:10
    Gk(i) = entropy(i,transition_states);
end
figure(1)
plot(Gk,'m','LineWidth',2)
xlabel('k','Interpreter','latex')
%% Calculating Huffman avrage length
AverageLength = zeros(1,10);
for k = 1:10
    AverageLength(k) = average_length(sampels,k);
end
figure(1)
hold on
plot(AverageLength,'c','LineWidth',2)
%% Code Efficiency 
H = (1:10).^(-1).*AverageLength;
H_X = -P*log2(P');
Code_Eff = H_X./H;
figure(1)
hold on
plot(Code_Eff,'g','LineWidth',2)
plot(ones(1,10)*H_X,'r','LineWidth',2)
legend('Gk','Average Length','Code Efficiency','Entropy')
%% Generating 10,000 sampels for X^3
TS = [ones(1,27)*0.343; %aaa
      ones(1,27)*0.024389; %bbb
      ones(1,27)*1.0000e-06; %ccc
      ones(3,27)* 0.1421; %aab,aba,baa
      ones(3,27)* 0.0049; %aac,aca,caa
      ones(3,27)* 0.05887; %bba,bab,abb
      ones(3,27)* 8.4100e-04; %bbc,bcb,cbb
      ones(3,27)* 7.0000e-05; %cca,cac,acc
      ones(3,27)* 2.9000e-05; %ccb,cbc,bcc
      ones(6,27)*0.00203]';% abc and its permutation
P = [0.343 0.024389 1.0000e-06 ones(1,3)*0.1421, ones(1,3)*0.0049,... 
     ones(1,3)*0.05887, ones(1,3)*8.4100e-04, ones(1,3)*7.0000e-05,...
     ones(1,3)* 2.9000e-05, ones(1,6)*0.00203];
 
% determining the first state
FS = sum(rand >= cumsum([0, P])); %First State
state = FS;
sampels = cell(1,10000);

for i = 1:10000
        NS = sum(rand >= cumsum([0, TS(state,:)])) ;
        if NS == 1
            sampels{i} = 'AAA';
        elseif NS == 2
            sampels{i} = 'BBB';
        elseif NS == 3
            sampels{i} = 'CCC';
        elseif NS == 4  ,sampels{i} = 'AAB';
        elseif NS == 5  ,sampels{i} = 'ABA'; 
        elseif NS == 6  ,sampels{i} = 'BAA';
            
        elseif NS == 7  ,sampels{i} = 'AAC';
        elseif NS == 8  ,sampels{i} = 'ACA';
        elseif NS == 9  ,sampels{i} = 'CAA';
        
        elseif NS == 10  ,sampels{i} = 'BBA';
        elseif NS == 11  ,sampels{i} = 'BAB';
        elseif NS == 12  ,sampels{i} = 'ABB';
            
        elseif NS == 13  ,sampels{i} = 'BBC';
        elseif NS == 14  ,sampels{i} = 'BCB';
        elseif NS == 15  ,sampels{i} = 'CBB';    
            
        elseif NS == 16  ,sampels{i} = 'CCA';
        elseif NS == 17  ,sampels{i} = 'CAC';
        elseif NS == 18  ,sampels{i} = 'ACC';
           
        elseif NS == 19  ,sampels{i} = 'CCB';
        elseif NS == 20  ,sampels{i} = 'CBC';
        elseif NS == 21  ,sampels{i} = 'BCC';
        
        elseif NS == 22  ,sampels{i} = 'ABC';
        elseif NS == 23  ,sampels{i} = 'ACB';
        elseif NS == 24  ,sampels{i} = 'CAB';
        elseif NS == 25  ,sampels{i} = 'BAC';
        elseif NS == 26  ,sampels{i} = 'BCA';
        elseif NS == 27  ,sampels{i} = 'CBA';
        end
        state=NS;
end
%% Calculating Gk for k = 1,2,...,10
transition_states = TS;
Gk = zeros(10,1);
for i =1:10
    Gk(i) = entropy(i,transition_states,P');
end
figure(1)
plot(Gk,'m','LineWidth',2)
xlabel('k','Interpreter','latex')
%% Calculating Huffman avrage length
AverageLength = zeros(1,10);
for k = 1:10
    AverageLength(k) = average_length(sampels,k);
end
figure(1)
hold on
plot(AverageLength,'c','LineWidth',2)
%% Code Efficiency 
H = (1:10).^(-1).*AverageLength;
H_X = -P*log2(P');
Code_Eff = H_X./H;
figure(1)
hold on
plot(Code_Eff,'g','LineWidth',2)
plot(ones(1,10)*H_X,'r','LineWidth',2)
legend('Gk','Average Length','Code Efficiency','Entropy')
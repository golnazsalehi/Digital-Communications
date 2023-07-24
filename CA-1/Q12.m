%% Generating 10,000,000 sampels 
TS = [0.5 0.5; 0.8 0.2];
P = [8/13 5/13];

% determining the first state
FS = sum(rand >= cumsum([0, P(1), P(2)])); %First State
state = FS;
sampels = cell(1,10000000);
for i = 1:10000000
        NS = sum(rand >= cumsum([0, TS(state,1), TS(state,2)])) ;
        if NS == state
            sampels{i} = 'B';
        else
            sampels{i} = 'A';
        end
        state=NS;
end
%% Calculating Gk for k = 1,2,...,10
Gk = zeros(1,10);
for k = 1:10
    Gk(k) = entropy(k,TS);
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
legend('Gk','Average Length')
%% Code Efficiency 
H = (1:10).^(-1).*AverageLength;
H_X = 0.893;
Code_Eff = H_X./H;
figure(2)
plot(Code_Eff,'m','LineWidth',2)
xlabel('k','Interpreter','latex')
hold on
plot(ones(1,10)*H_X,'c','LineWidth',2)
legend('Code Efficiency ','Entropy')


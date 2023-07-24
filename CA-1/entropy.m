function Gk = entropy(k,transition_states,p)
    ts = transition_states';
    [r,c] = size(ts);
    if nargin ==2
    ts = [ts; ones(1,c)];
    ts = [ts,zeros(r+1,1)];
    ts = ts - eye(r+1); 
    p = sym('p',[r,1]);
    probs = [];
    for i =1:r
        probs =[probs; p(i)];
    end
    probs(end+1) =1;
    eqn = ts * probs==0;
    P = struct2cell(solve(eqn));
    P = double(vpa(P));
    else
        P =p;
    end
    %-------------------
    H_S1 = -P'*log2(P);
    %-------------------
    ts = transition_states';
    ts_0 = ts==0;
    ts = ts +ts_0;
    H_S2_S1 = P'*(dot(eye(r),(-ts'*log2(ts)))');
    %-------------------
    Gk = (H_S1+k*H_S2_S1)/k;
end
function avglen = average_length(chain,k)
    chain = cell2mat(chain);
    
    pack = floor(numel(chain)/k);
    new_chain = reshape(chain(1:pack*k),[k,pack])';
    if pack~=numel(chain)/k
        tale = chain(pack*k+1:end);
    else
        tale = [];
    end
    
    [Mu,~,ic] = unique(new_chain, 'rows', 'stable');  
    h = accumarray(ic, 1);
    [sym_num,~] = size(Mu);
    if ~isempty(tale)
        h(end+1) =1;
        Mu = 1:sym_num+1;
    else
        Mu = 1:sym_num;
    end

    
    h = h/sum(h);

    [~,avglen] = huffmandict(Mu,h);
    

end
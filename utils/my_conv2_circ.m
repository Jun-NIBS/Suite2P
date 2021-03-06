function S1 = my_conv2_circ(S1, sig, varargin)
% takes an extra argument which specifies which dimension to filter on
% extra argument can be a vector with all dimensions that need to be
% smoothed, in which case sig can also be a vector of different smoothing
% constants

if sig>.25
    idims = 2;
    if ~isempty(varargin)
        idims = varargin{1};
    end
    if numel(idims)>1 && numel(sig)>1
        sigall = sig;
    else
        sigall = repmat(sig, numel(idims), 1);
    end
    
    for i = 1:length(idims)
        sig = sigall(i);
        
        idim = idims(i);
        Nd = ndims(S1);
        
        S1 = permute(S1, [idim 1:idim-1 idim+1:Nd]);        
        ds1 = size(S1);        
        nO = 4*sig;
        NT = size(S1,1);        
        
        S1 = cat(1, S1(size(S1,1)-nO + [1:nO], :),  S1(:,:), S1([1:nO], :));
%         S1 = cat(1, S1([nO:-1:1], :),  S1(:,:), S1(size(S1,1)-nO + [nO:-1:1], :));
        
        S1 = my_conv(S1, sig);        
        S1 = S1(nO + [1:NT], :);

        S1 = reshape(S1, ds1);
%         S1 = my_conv(S1, sig);

        S1 = permute(S1, [2:idim 1 idim+1:Nd]);
    end
end




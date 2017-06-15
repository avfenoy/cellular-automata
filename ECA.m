function [ca, wrule] = ECA(rule, width, timesteps, init)

% ECA Creates an elementary cellular automata with periodic boundary conditions, and plots it
%
%   Inputs:
%       rule - the Wolfram rule to update the state of the system
%       width - number of cells
%       timesteps - number of generations
%       init - the initial condition, as a vector in binary
%
%   Output:
%       ca - a matrix showing the evolution of the cellular automata. Each
%       row is one generation, columns are timesteps (up->down)
%       wrule - binary representation of the given rule


wrule = de2bi(rule, 8, [], 'left-msb'); % convert to binary

cawidth = width;
catimes = timesteps;

ca = zeros(catimes, cawidth);
ca(1,:) = init;

% interactions in the boundaries
for timestep = 2:catimes
    for nbit = 1:cawidth
        if nbit == 1
            current = ca(timestep-1, [cawidth nbit nbit+1]);
        elseif nbit == cawidth
            current = ca(timestep-1, [nbit-1 nbit 1]);
        else
            current = ca(timestep-1,nbit-1:nbit+1);
        end
        ca(timestep,nbit) = wrule(8-bi2de(current,[],'left-msb'));        
    end
end


% plot graphic
[r,c] = size(ca);
imagesc((1:c)+0.5,(1:r)+0.5,ca);
colormap(flipud(gray));
axis equal    
set(gca,'XTick',1:(c+1),'YTick',1:(r+1),'XLim',[1 c+1],'YLim',[1 r+1],'GridLineStyle','-','XGrid','on','YGrid','on');
    
end

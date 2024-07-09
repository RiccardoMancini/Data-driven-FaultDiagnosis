function plotClassDistribution (classes)
% plotClassDistribution(classes)
% Restituisce il plot di un istogramma della distribuzione delle classi.
%
% Input:
%   classes: Vettore contenente le classi (numeriche o categoriche) di cui si vuole visualizzare la distribuzione.
%
% Output:
%   Un grafico a barre (istogramma) che mostra il numero di occorrenze per ciascuna classe.

figure;

h = histogram(classes, 11); % plot distribuzione predizioni

x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2; % centro delle barre
y = h.Values;

for i = 1:length(x)
    text(x(i), y(i), num2str(y(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

xlabel('Classe')
ylabel('Numero di Occorrenze')
title('Distribuzione delle Predizioni di Classe')
ylim([0, max(y)+300])
end
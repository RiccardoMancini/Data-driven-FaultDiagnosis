function finalTable = replaceNaN(T)
% Sostituisce i valori NaN in una tabella con la media della feature calcolata per la rispettiva classe.
%
% Input:
%   T: Tabella di dati contenente una colonna 'Fault' e altre colonne con feature numeriche.
%
% Output:
%   finalTable: Tabella con gli stessi dati di T, ma con i valori NaN sostituiti dalla media della feature corrispondente 
%               calcolata per la classe di appartenenza di ogni riga.

classiUniche = unique(T.Fault);

% Itera su ciascuna classe unica
for i = 1:length(classiUniche)
    classe = classiUniche(i); 
    indiciClasse = T.Fault == classe; % Trova gli indici delle righe appartenenti alla classe corrente
    nomiFeature = T.Properties.VariableNames;
    nomiFeature(strcmp(nomiFeature, 'Fault')) = [];
    
    % Itera su ciascuna feature
    for j = 1:length(nomiFeature)
        feature = nomiFeature{j};
        
         % Calcola la media della feature per la classe corrente, escludendo i NaN
        mediaFeature = mean(T.(feature)(indiciClasse), 'omitnan');

        % Sostituisci i NaN nella feature corrente con la media calcolata, solo per le righe della classe corrente
        T.(feature)(indiciClasse & isnan(T.(feature))) = mediaFeature;
    end
end
finalTable = T;
end
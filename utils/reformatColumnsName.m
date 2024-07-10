function fullTable = reformatColumnsName(T)
% fullTable = reformatColumnsName(T)
% Riformatta i nomi delle colonne di una tabella, rimuovendo la parte centrale se presente.
%
% Input:
%   T: Tabella di dati in cui i nomi delle colonne possono avere il formato
%      "<sensore>/<dir>/<feature>" o "<sensore>/<feature>".
%
% Output:
%   fullTable: Tabella con i nomi delle colonne riformattati nel formato "<sensore>/<feature>", 
%              rimuovendo la parte "/<dir>/" se presente.

columnNames = T.Properties.VariableNames;

for i = 2:length(columnNames)
    parts = strsplit(columnNames{i}, '/');
    
    if length(parts) == 3
        newName = [parts{1} '/' parts{3}];        
        columnNames{i} = newName;
    else
        error('Il formato del nome della colonna non è valido: %s', columnNames{i});
    end
end

T.Properties.VariableNames = columnNames;
fullTable = T;

clear columnNames; i; newName; parts;
end
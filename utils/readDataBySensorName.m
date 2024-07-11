function fullDataTable = readDataBySensorName(sensore, path)
% fullDataTable = readDataBySensorName(sensore)
% Legge i dati dai file CSV del sensore specificato e li unisce in una tabella.
%
% Input:
%   sensore: Nome del sensore (stringa, es. "pin").
%   path: Percorso da cui leggere i file CSV.
%
% Output:
%   fullDataTable: Tabella contenente i dati di tutti i file CSV del sensore.


file_list = dir(path);

% Scansione dei file CSV nella directory specificata
matching_files = [];
for i = 1:length(file_list)
    if contains(file_list(i).name, sensore) && ~file_list(i).isdir
        matching_files = [matching_files; {file_list(i).name}];
    end
end

% Letture e unione dei dati da ciascun file
matching_files = string(matching_files);
fullDataTable = [];
colonnaEtichetta = 1;
max_columns = 513; % 1 fault code + 512 istanti temporali
for i = 1:length(matching_files)        
    disp(strcat("In elaborazione: ", matching_files(i)));
    dataTable = readtable(strcat(path, matching_files(i)), 'ReadVariableNames', false);
    dataTable = dataTable(: , 1:max_columns);
    
    % Conversione delle celle della tabella in numeri decimali
    for j = 1:width(dataTable)
        if j ~= colonnaEtichetta && iscell(dataTable.(j))
            dataTable.(j) = str2double(dataTable.(j));
        end
    end
    
    % Conversione la colonna etichetta (faul-code) in intero
    if iscell(dataTable.(colonnaEtichetta))
        dataTable.(colonnaEtichetta) = int32(str2double(dataTable.(colonnaEtichetta))); 
    end

    % Concatenazione verticale della tabella corrente con la tabella finale
    if isempty(fullDataTable)
        fullDataTable = dataTable;
    else
        fullDataTable = [fullDataTable; dataTable];
    end
end
end
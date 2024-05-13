function dataTable = readDataset(nomeFile)

    % Importa il file CSV in una tabella
    dataTable = readtable(nomeFile);

    colonnaEtichetta = 1;
    % Converti le colonne in numeri reali (tranne l'etichetta)
    for i = 1:width(dataTable)
        if i ~= colonnaEtichetta && iscell(dataTable.(i)) % Controlla se la colonna contiene stringhe
            dataTable.(i) = str2double(dataTable.(i));
        end
    end

    % Converte la colonna dell'etichetta in interi
    if iscell(dataTable.(colonnaEtichetta)) % Controlla se la colonna contiene stringhe
        dataTable.(colonnaEtichetta) = int32(str2double(dataTable.(colonnaEtichetta))); 
    end

    
end

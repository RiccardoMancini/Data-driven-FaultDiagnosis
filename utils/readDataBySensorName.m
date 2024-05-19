function fullDataTable = readDataBySensorName(sensore)
    
    file_list = dir("./data/");
    matching_files = [];
    for i = 1:length(file_list)
        if contains(file_list(i).name, sensore) && ~file_list(i).isdir
            matching_files = [matching_files; {file_list(i).name}];
        end
    end
    
    matching_files = string(matching_files);
    fullDataTable = [];
    colonnaEtichetta = 1;
    max_columns = 572;
    for i = 1:length(matching_files)        
        disp(strcat("In elaborazione: ", matching_files(i)));
        dataTable = readtable(strcat("./data/", matching_files(i)), 'ReadVariableNames', false);
        dataTable = dataTable(: , 1:max_columns);
        
        % Converti le colonne in numeri reali (tranne l'etichetta)
        for j = 1:width(dataTable)
            if j ~= colonnaEtichetta && iscell(dataTable.(j)) % Controlla se la colonna contiene stringhe
                dataTable.(j) = str2double(dataTable.(j));
            end
        end
    
        % Converte la colonna dell'etichetta in interi
        if iscell(dataTable.(colonnaEtichetta)) % Controlla se la colonna contiene stringhe
            dataTable.(colonnaEtichetta) = int32(str2double(dataTable.(colonnaEtichetta))); 
        end

        if isempty(fullDataTable)
            fullDataTable = dataTable;
        else
            % fullDataTable = outerjoin(fullDataTable, dataTable,'MergeKeys', true);
            fullDataTable = [fullDataTable; dataTable];
        end
    end
end

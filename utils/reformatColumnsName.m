function fullTable = reformatColumnsName(T) % riformatta le colonne da "<sensore>/<dir>/<feature>" a "<sensore>/<feature>"
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


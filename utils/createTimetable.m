function newTable = createTimetable(fullTable)
% newTable = createTimetable(fullTable);
% Converte una tabella di dati in una tabella con una colonna 'Fault' 
% e una colonna 'Serie' di tipo timetable.
%
% Input:
%   fullTable: Tabella di dati in cui la prima colonna rappresenta l'etichetta 'Fault' 
%   e le restanti colonne sono dati numerici relativi agli istanti
%   della serie temporale
%
% Output:
%   newTable: Timetable con due colonne ('Fault' (etichetta) e 'Serie').

newTable = table();

for i = 1:size(fullTable, 1)
    app = table2array(fullTable(i, 2:end));
    tt = array2timetable(app', TimeStep=seconds(0.00002)); % freq. di campionamento 50kHz      
    newTable = [newTable; {fullTable.(1)(i), tt}];
end

newTable.Properties.VariableNames = {'Fault', 'Serie'};

clear tt app i;
end
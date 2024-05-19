function newTable = createTimetable(fullTable)
    newTable = table();

    for i = 1:size(fullTable, 1)
        app = table2array(fullTable(i, 2:end));
        tt = array2timetable(app', TimeStep=seconds(0.00002));        
        newTable = [newTable; {fullTable.(1)(i), tt}];
    end

    newTable.Properties.VariableNames = {'Fault', 'Serie'};
    
    clear tt app i;
end

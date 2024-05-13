newTable = table();

for i = 1:size(table_pin1, 1)
%for i = 1:1000
    app = table2array(table_pin1(i, 2:end));
    %disp(app);
    tt = array2timetable(app', TimeStep=seconds(0.02));
    
    newTable = [newTable; {table_pin1.(1)(i), tt}];
end

newTable.Properties.VariableNames = {'Fault', 'Serie'};

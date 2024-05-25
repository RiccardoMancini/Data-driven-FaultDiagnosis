addpath("./utils/");


% Estrarre il numero di colonne minimo tra tutti i .csv (per evitare NaN alla fine della serie)
% file_list = dir("./data/");
% matching_files = [];
% for i = 3:length(file_list)
%     matching_files = [matching_files; {file_list(i).name}];
% end
% 
% matching_files = string(matching_files);
% minRowLength = Inf;
% 
% for i = 1:length(matching_files)
%     disp(strcat("In elaborazione: ", matching_files(i)));
%     data = readtable(strcat("./data/", matching_files(i)), 'ReadVariableNames', false);
%     % Itera attraverso le righe della tabella
%     for j = 1:height(data)
%         rowLength = sum(~cellfun('isempty', table2cell(data(j, :)))); % Conta le celle non vuote nella riga
% 
%         % Aggiorna la lunghezza minima della riga se necessario
%         if rowLength < minRowLength
%             minRowLength = rowLength;
%         end
%     end
% 
%     % Visualizza il risultato
%     disp(['Minimum columns in ' matching_files(i), ' is: ', num2str(minRowLength)]);
% 
% end


% LETTURA E CREAZIONE DI TABLE CON FAULT E TIMETABLE PER OGNI SENSORE
% table_pin= readDataBySensorName("pin");
% table_pin_TT = createTimetable(table_pin);
% 
% table_po = readDataBySensorName("po");
% table_po_TT = createTimetable(table_po);
% 
% table_pdmp = readDataBySensorName("pdmp");
% table_pdmp_TT = createTimetable(table_pdmp);


% AGGIUNTA NOME SENSORE ALLE COLONNE 
% (DA RUNNARE POST ESTRAZIONE FEATURES) (da cambiare manualmente sia il nome che la variabile table)
% for i = 2:width(poFeature)
%     poFeature.Properties.VariableNames{i} = ['PO/', poFeature.Properties.VariableNames{i}];
% end
% 
% clear i;


% POST CONCATENAZIONE FEATURES IN UN'UNICA TABELLA
% T1 = pdmpFeature;
% T2 = pinFeature;
% T3 = poFeature;
% T2.Fault = [];
% T3.Fault = [];
% 
% T = [T1(:, :), T2(:, :), T3(:, :)];


% REPLACE DEI VALORI NaN NEL TRAIN E TEST SET
% trainingSet = replaceNaN(T);
% testSet = replaceNaN(T);


% FORMATTAZIONE NOME COLONNE IN UN PATTERN E ORDINAMENTO COMUNE
% trainingSet = reformatColumnsName(trainingSet);
% testSet = reformatColumnsName(testSet);
% [~, idx] = ismember(trainingSet.Properties.VariableNames, testSet.Properties.VariableNames);
% testSet = testSet(:, idx);
% clear idx;


% PLOT DEI SEGNALI
% plotSignal(table_po_TT, 500)
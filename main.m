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


% table_pin= readDataBySensorName("pin");
% table_pin_TT = createTimetable(table_pin);
% 
% table_po = readDataBySensorName("po");
% table_po_TT = createTimetable(table_po);
% 
% table_pdmp = readDataBySensorName("pdmp");
% table_pdmp_TT = createTimetable(table_pdmp);

% Stampa dei segnali
% plotSignal(table_po_TT, 500)

% Caricare le FeatureTable di ogni sensore singolo
% modifica nome delle colonne aggiungendo il nome del sensore 
% (da cambiare manualmente sia il nome che la table)
% for i = 2:width(pdmpFeature)
%     pdmpFeature.Properties.VariableNames{i} = ['PDMP/', pdmpFeature.Properties.VariableNames{i}];
% end
% 
% clear i;

% T1 = pdmpFeature;
% T2 = pinFeature;
% T3 = poFeature;
% T2.Fault = [];
% T3.Fault = [];
% 
% T = [T1(:, :), T2(:, :), T3(:, :)];
% 
% trainingSet = replaceNaN(T);
% testSet = replaceNaN(T);




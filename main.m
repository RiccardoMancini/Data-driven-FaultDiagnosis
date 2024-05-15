addpath("./utils/");

% num_colonne_minimo = Inf; % Inizia con un valore infinito
% nome_file_minimo = '';
% 
% % Ottieni la lista dei file CSV nella directory
% file_list = dir(fullfile("./data/", '*.csv'));
% 
% % Itera sui file CSV
% for i = 1:length(file_list)
%     % Leggi il file CSV in una tabella
%     table_corrente = readtable(fullfile("./data/", file_list(i).name));
% 
%     % Ottieni il numero di colonne della tabella corrente
%     num_colonne = width(table_corrente);
% 
%     % Verifica se il numero di colonne è inferiore al minimo attuale
%     if num_colonne < num_colonne_minimo
%         num_colonne_minimo = num_colonne;
%         nome_file_minimo = file_list(i).name;
%     end
% end



table_pin = readDataBySensorName("pin");
table_pin_TT = createTimetable(table_pin);

% table_po = readDataBySensorName("po");
% table_po_TT = createTimetable(table_po);

% table_pdmp = readDataBySensorName("pdmp");
% table_pdmp_TT = createTimetable(table_pdmp);





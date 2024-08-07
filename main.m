% ####################### NOTE INIZIALI #######################
%
% - Le fasi 1, 2, 3, 4 di tale script sono state ripetute sia per i dati di
%    training che per quelli di test.
% - La fase 5 non è più necessaria (si rimanda al Capitolo 2 della relazione).
% - Nella cartella di consegna sono già stati forniti "trainingSet" e "testSet" 
%   elaborati e pre-processati per essere impiegati nelle fasi 8 e 9.
%
% #############################################################



% Aggiunge le cartelle "utils" e "models-function (with cvp)" al percorso 
% di ricerca di MATLAB per consentire l'accesso alle funzioni in esse contenute
addpath("./utils/");
addpath("./models-function (with cvp)/");


% 1) CARICAMENTO E PREPARAZIONE DATI PER OGNI SENSORE:
% - Legge i dati grezzi da file CSV per ogni sensore specificato come
%   parametro
% - Converte i dati in timetable, creando una colonna 'Serie' per le serie 
%   temporali
% - Memorizza i dati grezzi e le timetable in opportune strutture dati

% table_pin = readDataBySensorName("pin", "./train-data/");
% table_pin_TT = createTimetable(table_pin);
% 
% table_po = readDataBySensorName("po", "./train-data/");
% table_po_TT = createTimetable(table_po);
% 
% table_pdmp = readDataBySensorName("pdmp", "./train-data/");
% table_pdmp_TT = createTimetable(table_pdmp);



% ################ 2) FASE DFD Tool (Estrazione features) ################
% 2.1) PLOT DEI SEGNALI
% - Consente di visualizzare a schermo i segnali esportati dal DFD

% plotSignal(Ensemble1PO, 5000);



% 3) AGGIUNTA DEL PREFISSO DEL NOME DEL SENSORE AI NOMI DELLE COLONNE DELLE FEATURES:
% - Itera su ogni tabella di features estratte (POFeatures, PINFeatures, PDMPFeatures)
% - Aggiunge il nome del sensore come prefisso a ogni nome di colonna (es: 'PO/Feature1')
% - Questo facilita l'identificazione della provenienza delle features

% for i = 2:width(POFeatures)
%     POFeatures.Properties.VariableNames{i} = ['PO/', POFeatures.Properties.VariableNames{i}];
% end
% 
% clear i;
%
% for i = 2:width(PINFeatures)
%     PINFeatures.Properties.VariableNames{i} = ['PIN/', PINFeatures.Properties.VariableNames{i}];
% end
% 
% clear i;
%
% for i = 2:width(PDMPFeatures)
%     PDMPFeatures.Properties.VariableNames{i} = ['PDMP/', PDMPFeatures.Properties.VariableNames{i}];
% end
% 
% clear i;



% 4) CONCATENAZIONE DELLE FEATURES IN UN'UNICA TABELLA:
% - Unisce le tabelle delle features (PDMPFeatures, PINFeatures, POFeatures) in un unico dataset
% - Rimuove la colonna 'Fault' duplicata dalle tabelle PINFeatures e POFeatures

% T1 = PDMPFeatures;
% T2 = PINFeatures;
% T3 = POFeatures;
% T2.Fault = [];
% T3.Fault = []; 
% T = [T1(:, :), T2(:, :), T3(:, :)];



% 5) SOSTITUZIONE DEI VALORI NaN NEL TRAIN E TEST SET:
% - Applica la funzione 'replaceNaN' per sostituire i valori NaN sia nel
%   training set che nel test set
% - La funzione 'replaceNaN' sostituisce i NaN con la media della feature
%   corrispondente, calcolata per ogni classe

% trainingSet = replaceNaN(T);
% testSet = replaceNaN(T);



% 6) FORMATTAZIONE DEI NOMI DELLE COLONNE E ORDINAMENTO COMUNE:
% - Applica la funzione 'reformatColumnsName' per uniformare il formato dei
%   nomi delle colonne nel training e test set
% - Assicura che le colonne nei due set siano nello stesso ordine prima di
%   passare i dataset in pasto al Classification Learner tool

% trainingSet = reformatColumnsName(trainingSet);
% testSet = reformatColumnsName(testSet);
% [~, idx] = ismember(trainingSet.Properties.VariableNames, testSet.Properties.VariableNames);
% testSet = testSet(:, idx);
% clear idx;



% ########## 7) FASE Classification Learner Tool (cross-val senza stratificazione) #########
% 7.1)  FASE Classification Learner Tool (test dei campioni non guasti):
% - Filtra il test set da tutti i campioni di cui non si conosce la classe
%   (classe 0)
% - Il risultato di tale filtraggio (testSet1) dovrà essere importato nel 
%   tool per darli in pasto ai modelli addestrati

% testSet1 = testSet(testSet.Fault == 1, :);



% 8) ADDESTRAMENTO E VALIDAZIONE DEL MODELLO TRAMITE CROSS-VALIDATION CON
%    STRATIFICAZIONE:
% - Addestra un modello di classificazione utilizzando la funzione specifica
% - Calcola l'accuratezza di validazione del modello

% Addestra il modello cubicSVM (da modificare con le funzioni presenti nella cartella "models-function (with cvp)")
% [trainedClassifier, validationAccuracy] = cubicSVM(trainingSet);
% yfit = trainedClassifier.predictFcn(testSet); % Vettore contente le classi predette



% 9) VISUALIZZAZIONE DELLA DISTRIBUZIONE DELLE CLASSI PREDETTE:

% plotClassDistribution(yfit); % Visualizza la distribuzione delle classi predette
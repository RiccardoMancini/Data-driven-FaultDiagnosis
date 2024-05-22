function finalTable = replaceNaN(T) % rimpiazza i valori NaN con la media della feature associata alla rispettiva classe

    classiUniche = unique(T.Fault);

    for i = 1:length(classiUniche)
        classe = classiUniche(i);
        indiciClasse = T.Fault == classe;    
        nomiFeature = T.Properties.VariableNames;
        nomiFeature(strcmp(nomiFeature, 'Fault')) = [];
    
        for j = 1:length(nomiFeature)
            feature = nomiFeature{j};
    
            mediaFeature = mean(T.(feature)(indiciClasse), 'omitnan');
            T.(feature)(indiciClasse & isnan(T.(feature))) = mediaFeature;
        end
    end
    finalTable = T;
end


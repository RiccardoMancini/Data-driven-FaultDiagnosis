function plotClassDistribution (classes)
    figure;

    %h = histogram(trainingSet.(1), 11); % plot distribuzione classi
    h = histogram(classes, 11); % plot distrubuzione predizioni
    
    % Ottieni i valori dell'asse x e y per ogni barra
    x = h.BinEdges(1:end-1) + diff(h.BinEdges)/2; % Centro delle barre
    y = h.Values;
    
    % Visualizza i valori numerici sopra le barre
    for i = 1:length(x)
        text(x(i), y(i), num2str(y(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    
    % Etichette e titolo
    xlabel('Classe')
    ylabel('Numero di Occorrenze')
    title('Distribuzione delle Predizioni di Classe')
    
    % Imposta il limite massimo dell'asse y a 5000
    ylim([0, max(y)+300])
end


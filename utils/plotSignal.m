function plotSignal(table_TT, nRows)
% plotSignal(table_TT, nRows);
% Visualizza le serie temporali o gli spettri di potenza raggruppati per fault code.
%
% Input:
%   table_TT: Tabella contenente le serie temporali (o gli spettri) e i fault code corrispondenti.
%             Si assume che la tabella abbia una colonna 'Fault' e una colonna 'Serie' (serie temporali o spettri).
%   nRows:    Numero massimo di campioni da visualizzare.
%
% Output:
%   Un grafico a linee in cui ogni fault code è rappresentato da un colore diverso. 
%   Le linee mostrano l'andamento delle serie temporali (o gli spettri di potenza) per ogni fault code.


uniqueFaults = unique(table_TT.Fault);
figure;
hold on;
handles = cell(length(uniqueFaults), 1);

colorMap = containers.Map('KeyType', 'double', 'ValueType', 'any');
predefinedColors = lines(length(uniqueFaults));

for i = 1:length(uniqueFaults)
    fault = uniqueFaults(i);
    colorMap(fault) = predefinedColors(i, :);
end

for i = 1:length(uniqueFaults)
    fault = uniqueFaults(i);
    
    app = table_TT(1:nRows, :);
    faultData = app(app.Fault == fault, :);
    
    color = colorMap(fault);
    
    for j = 1:height(faultData)
        serie = faultData.Serie{j};
        % plot(serie.Time, serie.Var1, 'Color', color); % per le serie temporali
        plot(serie.Frequency, serie.SpectrumData, 'Color', color);
        handles{i} = plot(NaN, NaN, 'Color', color, 'DisplayName', ['Fault ' num2str(fault)]);
    end
end

hold off;
handles = handles(~cellfun('isempty',handles));

legend([handles{:}], 'Location', 'northwest');
% xlabel('Time [ms]');     % per le serie temporali
% ylabel('Pressure [-]');  % per le serie temporali
xlabel('Frequency [kHz]');
ylabel('Power [dB]');
title('Serie temporali raggruppate per fault-code');

clearvars -except table_po_TT table_pin_TT table_pdmp_TT
end
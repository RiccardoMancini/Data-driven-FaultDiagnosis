function plotSignal(table_TT, nRows)
    uniqueFaults = unique(table_TT.Fault);
    figure;
    hold on;
    handles = cell(length(uniqueFaults), 1);
   
    for i = 1:length(uniqueFaults)
        fault = uniqueFaults(i);
        app = table_TT(1:nRows, :);
        faultData = app(app.Fault == fault, :);
        
        color = rand(1,3); 
        for j = 1:height(faultData)
            serie = faultData.Serie{j};
            plot(serie.Time, serie.Var1, 'Color', color);
            handles{i} = plot(NaN, NaN, 'Color', color, 'DisplayName', ['Fault ' num2str(fault)]);
        end
    end
    
    hold off;
    handles = handles(~cellfun('isempty',handles));

    legend([handles{:}], 'Location', 'northwest');
    xlabel('Tempo');
    ylabel('Dati');
    title('Serie Temporali Raggruppate per Fault');
    
    clearvars -except table_po_TT table_pin_TT table_pdmp_TT
end


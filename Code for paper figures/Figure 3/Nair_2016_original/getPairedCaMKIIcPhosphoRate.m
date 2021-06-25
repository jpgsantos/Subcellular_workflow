function [autophosphorylationRate] = getPairedCaMKIIcPhosphoRate(CaMKIIcContration, pCaMKIIcContration, totalCaMKII, maxAutophosphorylationRate)

    %This function calculates the possible concentration of eligible CaMKII
    %which can be phosphorylated, given the concentration of the following:
    %CaMKIIcContration: active non phosphorylated CaMKII concentration, 
    %pCaMKIIcContration: active phosphorylated CaMKII concentration, and 
    %totalCaMKII: total concentration of CaMKII. 
    
    %This calculated the concentration of "pairedCaMKIIc" using a
    %polynomial "0.0100 * x^2 - 0.0031 * x - 0.0007" which is derived from
    %the probabilities of two adjacent active CaMKII subunits in a hexamer
    %given the input concentrations. The function previously used to get
    %the polynomial fit is "getPairedCaMKIIc(CaMKIIcContration, 
    %pCaMKIIcContration, totalCaMKII, compartmentVolume, volumeUnit)"
    % which is commented below. This has only been tested for concentration
    % ranges interesting to me. This may give incorrected result if there
    % are exceptionally large or exceptionally small number of molecules
    % corresponding to "totalCaMKII".
    
    fittedPolynomial = [0.0100 -0.0031 -0.0007];
    
    totalActiveCaMKII = CaMKIIcContration + pCaMKIIcContration;
    percentActiveCaMKII = (totalActiveCaMKII ./ totalCaMKII) .* 100;
    percentPairedCaMKII = (fittedPolynomial(1) .* (percentActiveCaMKII .^ 2)) + (fittedPolynomial(2) .* percentActiveCaMKII) + (fittedPolynomial(3));
    
    if(percentPairedCaMKII < 0)
        percentPairedCaMKII = 0;
    end
    
    autophosphorylationRate = (percentPairedCaMKII ./ 100) .* maxAutophosphorylationRate;
end


% function [pairedCaMKIIc] = getPairedCaMKIIc(CaMKIIcContration, pCaMKIIcContration, totalCaMKII, compartmentVolume, volumeUnit)
%     
%     %The units for the CaMKIIcContration, pCaMKIIcContration and
%     %totalCaMKII in namolarity and the unit of compartmentVolume is in
%     %micrometer^3. The compartmentVolume corresponds to the volume of the
%     %current compartment for which the paired CaMKII concentration has to
%     %be calculated.
%     
%     volumeInLitre = sbiounitcalculator(volumeUnit, 'litre', compartmentVolume);
%     numberOfCaMKIIc = floor(sbiounitcalculator('nanomolarity', 'molecule/litre', CaMKIIcContration) ...
%                            .* volumeInLitre);
%     numberOfTotalActivatedCaMKII = floor(sbiounitcalculator('nanomolarity', 'molecule/litre', pCaMKIIcContration) ...
%                            .* volumeInLitre) + numberOfCaMKIIc;
%     numberOftotalCaMKII = floor(sbiounitcalculator('nanomolarity', 'molecule/litre', totalCaMKII) ...
%                            .* volumeInLitre);
%     
%     numberOfHexamers = ceil(numberOftotalCaMKII ./ 6);
%     populationCounter = [0 0 0 0 0 0];
%     iterations = 1000;
%     for i = 1:iterations
%         camkiiRingMatrix = zeros(numberOfHexamers, 6);
%         randomPositions = randperm(numberOfHexamers .* 6, numberOfTotalActivatedCaMKII);
%         for j = randomPositions
%             camkiiRingMatrix(j) = 1;
%         end
%         camkiiRingMatrix = sum(camkiiRingMatrix, 2);
%         [occurence, values] = hist(camkiiRingMatrix,[0 1 2 3 4 5 6]);
%         occurence = occurence(:, 2:end);
%         populationCounter = populationCounter + occurence;
%     end
%     
%     populationCounter = populationCounter ./ iterations;
%     probabilityVector = [0 0.2 0.4 0.6 0.8 1];
%     subunitCountVector = [1 2 3 4 5 6];
%     
%     pairedCaMKIIcMolecules = sum(populationCounter .* probabilityVector .* subunitCountVector);
%     if numberOfTotalActivatedCaMKII ~= 0
%         pairedCaMKIIcMolecules = pairedCaMKIIcMolecules .* (numberOfCaMKIIc ./ numberOfTotalActivatedCaMKII);
%     else
%         pairedCaMKIIcMolecules = 0;
%     end
%     
%     pairedMoleculesPerLitre = pairedCaMKIIcMolecules ./ volumeInLitre;
%     pairedCaMKIIc = sbiounitcalculator('molecule/litre', 'nanomolarity', pairedMoleculesPerLitre);
% end
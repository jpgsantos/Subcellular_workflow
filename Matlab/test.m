load('Reproduce paper figure 8/inputs')

Ca1 = [];
Da1 = [];
t1 = [];

for n = 1:500001
   
    
    if n <= 30000
        Ca1(n) = Ca(1);
        Da1(n) = Da(1);
        t1(n) = (n*0.0001-0.0001);
        
    elseif n > 30000 && n <= 90000
        Ca1(n) = Ca(n-30000);
        Da1(n) = Da(n-30000);
        t1(n) = (n*0.0001-0.0001);
        
    elseif n > 90000
        
        Ca1(n) = Ca(60000);
        Da1(n) = Da(60000);
        t1(n) = (n*0.0001-0.0001);
    end
    
    
end

Ca = Ca1;
Da = Da1;
t = t1;

% subplot(1,2,1)
% plot(t1,Ca1)
% subplot(1,2,2)
% plot(t1,Da1)
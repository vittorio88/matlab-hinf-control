% Mask for S
% Plots mask and Sdesign

attenwall=Ms_lf.value:0.01:S.design.p.value ;
attenwallfreq(1:length(attenwall))=dp.values.frequency;
figure
hold on
plot(attenwallfreq,attenwall,'color','r','linewidth',3)


attenfloorfreq = 10e-5 : 10e-5 : dp.values.frequency;
attenfloor(1:length(attenfloorfreq))= Ms_lf.value;
plot(attenfloorfreq,attenfloor,'color','r','linewidth',3)

attenrooffreq = dp.values.frequency : 10e-1 : Wc.design.value*10e1;
attenroof(1:length(attenrooffreq))= S.design.p.value;
plot(attenrooffreq,attenroof,'color','r','linewidth',3)

mag = squeeze(bode(S.design.value,vector.log.value))

plot(vector.log.value,mag)
hold off
% need to have run IPMSMTorqueBasedLoad_PQ.slx to generate
% PowerQualityData Dataset in the workspace

time = PowerQualityData{1}.Values.Time;

names = {};


tstart = 0.25;
tstop = 0.32;
dt = time(2)-time(1);
ind1 = find(time == tstart);
ind2 = find(time == tstop);
n = ind2-ind1;
tnew = 0:dt:(dt*n);
T = table(tnew');
for i = 1:PowerQualityData.numElements
    name = PowerQualityData{i}.Values.Name;
    data = PowerQualityData{i}.Values.Data;
    data = data(ind1:ind2);
    T = addvars(T,data,'NewVariableNames',name);
end
writetable(T,'power_quality_data.csv')


% need to have run IPMSMTorqueBasedLoad_PQ.slx to generate
% PowerQualityData Dataset in the workspace

time = PowerQualityData{1}.Values.Time;

names = {};
T = table(time);
for i = 1:PowerQualityData.numElements
    name = PowerQualityData{i}.Values.Name;
    data = PowerQualityData{i}.Values.Data;
    T = addvars(T,data,'NewVariableNames',name);
end
writetable(T,'power_quality_data.csv')


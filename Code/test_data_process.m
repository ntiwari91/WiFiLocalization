%--------- test_data_processing

function [avg_ap_signals,location] = test_data_process(path,testsite)
fid = fopen(path, 'rt');
%fid = fopen('./corridor_ujj','rt');
C = textscan(fid, '%d %d %s %s %s %d','CollectOutput', true);
fclose(fid);
%data_name1 = C{1};
%--- GCL-II ----
if (testsite==2)
    %ap_names = {'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c';'00:24:6c:96:ae:e'};
    ap_names={'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'}; %GCL-I
elseif (testsite==1) % --- GCL-I-----
    ap_names={'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'}; %GCL-I
else  % --- Corridor ----
    ap_names = {'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'}; % for corridor
end

sample_locations = C{1}(:,2);
location = unique(sample_locations);
location_iterations = C{1}(:,1);
location_details = C{2};
location_signals = C{3};
num_of_samples = length(unique(location_iterations)); 
num_of_ap = length(ap_names); 
avg_ap_signals = zeros(num_of_samples,num_of_ap);

for i=1:num_of_samples
        ind = find(location_iterations==i);
        iteration_ap_list = location_details(ind,3);
        iteration_signals = location_signals(ind); 
        for j=1:num_of_ap
            %ap_signals = [];
            L = strfind(iteration_ap_list,cell2mat(ap_names(j)));
            ap_signals = iteration_signals(find(~cellfun(@isempty,L)));
            avg_ap_signals(i,j) = mean(ap_signals);
        end
end

end

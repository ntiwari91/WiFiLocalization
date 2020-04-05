%---- Data Processing Module-----

function [avg_ap_signals] = data_process(path,testsite)
%fid = fopen('.\corridor_ujj', 'rt');
fid = fopen(path, 'rt');
C = textscan(fid, '%d %d %s %s %s %d','CollectOutput', true);
fclose(fid);
%data_name1 = C{1};
%--- GCL-II ----
if (testsite==2)
    %ap_names = {'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c';'00:24:6c:96:ae:e'};
    ap_names = {'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'};
elseif (testsite==1) % --- GCL-I-----
    ap_names={'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'}; %GCL-I
else  % --- Corridor ----
    ap_names = {'00:1a:1e:35:81:0';'00:24:6c:60:5c:a';'00:1a:1e:35:7e:c'}; % for corridor
end
sample_iterations = C{1}(:,1);
sample_locations = C{1}(:,2);
location_list = unique(sample_locations);
sample_details = C{2};
sample_signals = C{3};
num_of_samples = 10; 
num_of_ap = length(ap_names); 
avg_ap_signals = zeros(length(location_list)*num_of_samples,num_of_ap);

%avg_ap_signals = [];
for s=1:length(location_list)
    indx = find(sample_locations==s);
    location_iterations = sample_iterations(indx);
    location_details = sample_details(indx,:);
    location_signals = sample_signals(indx);
    for i=1:num_of_samples
        ind = find(location_iterations==i);
        iteration_ap_list = location_details(ind,3);
        iteration_signals = location_signals(ind); 
        for j=1:num_of_ap
            %ap_signals = [];
            L = strfind(iteration_ap_list,cell2mat(ap_names(j)));
            ap_signals = iteration_signals(find(~cellfun(@isempty,L)));
            avg_ap_signals(((s-1)*num_of_samples+i),j) = mean(ap_signals);
        end
        avg_ap_signals(((s-1)*num_of_samples+i),num_of_ap+1) = s;
    end
end

end

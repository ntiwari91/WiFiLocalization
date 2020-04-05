%---- test2 for WGUI2 ------
%------------------------------------------
% algo = 2;
% trainpath = '.\GCL-II_multipos_ujj.m';
% testpath = '.\test_case_GCL-II.m';
% testsite = 2;
%-------------------------------------------
%trainpath
%testpath
train_avg_ap_signals = data_process(trainpath,testsite);
[test_avg_ap_signals,actual_sector] = test_data_process(testpath,testsite);

switch algo
    case 1 % Classification through Decision Tree
        tree = fitctree(train_avg_ap_signals(:,1:end-1),train_avg_ap_signals(:,end));
        prediction = predict(tree, test_avg_ap_signals);
        %error = nnz(prediction - avg_ap_signals(:,end));
        pred_sector = mode(prediction);
        %set(handles.edit_sector,'String',pred_sector);
        %set(handles.edit_act_sector,'String',actual_sector);
        
    case 2 % Classification through SVM 
        addpath('C:\Users\Ujjwal\Documents\MATLAB\Wireless\liblinear-1.96\matlab');
        svm_model = train(train_avg_ap_signals(:,end),sparse(train_avg_ap_signals(:,1:end-1)),'-q ');
        [label] = predict(zeros(size(test_avg_ap_signals,1),1),sparse(test_avg_ap_signals),svm_model,'-q');
        pred_sector = mode(label);
        %set(handles.edit_sector,'String',pred_sector);
        %set(handles.edit_act_sector,'String',actual_sector);
        
    case 3
        qda = fitcdiscr(train_avg_ap_signals(:,1:end-1),train_avg_ap_signals(:,end),...
            'DiscrimType','pseudoquadratic');
        prediction = predict(qda, test_avg_ap_signals);
        pred_sector = mode(prediction);
        %set(handles.edit_sector,'String',pred_sector);
        %set(handles.edit_act_sector,'String',actual_sector);
    
    case 4
        mdl = fitcknn(train_avg_ap_signals(:,1:end-1),train_avg_ap_signals(:,end));
        prediction = predict(mdl, test_avg_ap_signals);
        pred_sector = mode(prediction);
    
    otherwise
        
end

switch testsite 
    case 1
        loc_img = imread('.\Maps\Gcl-1new.jpg');
        axes(handles.axes1);
        imshow(loc_img,'InitialMagnification','fit');
        %t=({['text_A=' num2str(x)];['text_B=' num2str(y)];['text_C=' num2str(z)]});
        title({['Signal Quality (in %)- AP1: ' num2str(mean(test_avg_ap_signals(:,1)))...
                                     ',AP2: ' num2str(mean(test_avg_ap_signals(:,2)))...
                                     ',AP3: ' num2str(mean(test_avg_ap_signals(:,3)))];...
               ['* - Actual Sector, + - Predicted Sector']; });
        hold on;
        plot_pred;
        %[x,y] = ginput(1)
        plot_actual;
        
    case 2
        loc_img = imread('.\Maps\GCL-22.jpg');
        axes(handles.axes1);
        imshow(loc_img,'InitialMagnification','fit');
        title({['Signal Quality (in %)- AP1: ' num2str(mean(test_avg_ap_signals(:,1)))...
                                     ',AP2: ' num2str(mean(test_avg_ap_signals(:,2)))...
                                     ',AP3: ' num2str(mean(test_avg_ap_signals(:,3)))];...
               ['* - Actual Sector, + - Predicted Sector']; });
        hold on;
        plot_pred;
        plot_actual;
        
    case 3
        loc_img = imread('.\Maps\corridor11.jpg');
        axes(handles.axes1);
        imshow(loc_img,'InitialMagnification','fit');
        title({['Signal Quality (in %)- AP1: ' num2str(mean(test_avg_ap_signals(:,1)))...
                                     ',AP2: ' num2str(mean(test_avg_ap_signals(:,2)))...
                                     ',AP3: ' num2str(mean(test_avg_ap_signals(:,3)))];...
               ['* - Actual Sector, + - Predicted Sector']; });
        hold on;
        plot_pred;
        plot_actual;
    otherwise
end
        
        

function [cloudMat,nxx,nyy,cover]=SW_cloud_load(satellite,nxx,nyy,cover,type)
%% this is for load Landsat8 Cloudmat, and computer radiance

% 2024.05.17

%% 这里是选择landsat8的
switch satellite
    case 'landsat8'
        filepath = 'D:\Code\MATLABcode\cloudAndSea\clouddatabase\landsat8\landsat8\';
        filelist = dir(strcat(filepath,'*.mat'));

        %% 随机挑选一个mat 来计算辐射
        cloudnum=length(filelist)-4;
        load([filepath,filelist(cloudnum).name]);

    case 'KX'
        %% 这里选择新技术卫星的图
        filepath = 'D:\JWS\Code\MatlabCode\SW\静态云仿真\658\';
        filelist = dir(strcat(filepath,'*.mat'));
        cloudnum = randi(length(filelist));

        loadedData = load([filepath,filelist(cloudnum).name]);
        varNames = fieldnames(loadedData);
        originalVarName = varNames{1};
        cloudMat = loadedData.(originalVarName);

    case 'ql22'
        % filepath = 'D:\Code\MATLABcode\cloudAndSea\clouddatabase\landsat8\computeCloudRad_MR_20241119\';
        % % filelist = dir(strcat(filepath,'qlDatabase.mat'));
        % % load(strcat(filepath,'qlDatabase.mat'))
        cloudnum = 2;
        % loadedData = load([strcat(filepath,'qlDatabase.mat')]);
        % varNames = fieldnames(loadedData);
        % originalVarName = varNames{1};
        % cloudMatTest = loadedData.(originalVarName);
        % cloudMat =  cloudMatTest(:,:,cloudnum);
        imageFolder = 'D:\JWS\Code\MatlabCode\SW\静态云仿真\';
        outputFolder = fullfile(imageFolder, 'ProcessedImages\'); % 设置保存分割后图像的文件夹
        filelist = dir(strcat(outputFolder,'*.png'));
        cloudMat = double(imread([outputFolder,filelist(cloudnum).name]));
        cloudMat = imresize(cloudMat,[400,400]);
    case 'simulation'
        [cloudMat]=SW_cloud_gen(nxx,nyy,cover,type);
end
[nxx,nyy] = size(cloudMat);
cover = nnz(cloudMat)/nxx/nyy;
cover



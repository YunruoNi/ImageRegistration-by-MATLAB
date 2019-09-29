files= dir('/Users/n.y.r/Desktop/Aging/PPMRMAT');
load Fixed.mat
parfor i = 1:length(files)
    disp(i);
    tmp = files(i);
    if endsWith(tmp.name, '.mat')
        fn= tmp.name(1:length(tmp.name)-4);
        foo = load(sprintf('/Users/n.y.r/Desktop/Aging/PPMRMAT/%s.mat',fn));
%         load_fn = sprintf('Aging/PPMI/%s.nii',fn);
%         save_fn = sprintf('Aging/MRI/%s.mat',fn);
%         data = niftiread(load_fn);
%         save(save_fn, 'data')
%         disp(i);
        
          % 1. Load Data
          fixedVolume=mri;
          movingVolume=foo.data;
          centerFixed = size(fixedVolume)/2;
          centerMoving = size(movingVolume)/2;
          centerFixed= round (centerFixed);
          centerMoving= round (centerMoving);
% 
%           figure;
%           imshowpair(movingVolume(:,:,centerMoving(3)), fixedVolume(:,:,centerFixed(3)));
%           title('Unregistered Axial Slice');

          % 2. Filter
          %GaussFilter=imgaussfilt3(data,2);
          %fixedVolume=imgaussfilt3(mri,2);
          %MedianFilter = medfilt3(data);

          %3. ImageRegistration
          [optimizer, metric] = imregconfig('multimodal');
          optimizer.InitialRadius = 0.009;
          optimizer.Epsilon = 1.5e-4;
          optimizer.GrowthFactor = 1.01;
          optimizer.MaximumIterations = 300;

          movingRegistered = imregister(movingVolume, fixedVolume, 'similarity', optimizer, metric);
          %movingRegistered2 = imregister(MedianFilter, fixedVolume, 'affine', optimizer, metric);

%           figure;
%           subplot(1,3,1)
%           imshowpair(movingRegistered(:,:,centerFixed(3)), fixedVolume(:,:,centerFixed(3)));
%           subplot(1,3,2)
%           imshowpair(squeeze(movingRegistered(:,centerFixed(2),:)), squeeze(fixedVolume(:,centerFixed(2),:)));
%           subplot(1,3,3)
%           imshowpair(squeeze(movingRegistered(centerFixed(1),:,:)), squeeze(fixedVolume(centerFixed(1),:,:)));
%           title('Axial Slice of Registered Volume');

          %4.Save
          parsave (sprintf('/Users/n.y.r/Desktop/Aging/PPMRMATRESULT(Similarity)/%s.mat',fn), movingRegistered)


% figure;
% imshowpair(movingRegistered2(:,:,centerFixed(3)), fixedVolume(:,:,centerFixed(3)));
% title('Axial Slice of Median Registered Volume');
    end
end

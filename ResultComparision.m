% compare outputs
files= dir('/Users/n.y.r/Desktop/Aging/PPMRMATRESULT(Similarity)');
load Fixed.mat
for i = 1:length(files)
%     disp(i);
    tmp = files(i);
    if endsWith(tmp.name, '.mat')
        fn= tmp.name(1:length(tmp.name)-4);
        foo = load(sprintf('/Users/n.y.r/Desktop/Aging/PPMRMATRESULT(Similarity)/%s.mat',fn));
        
        fixedVolume=mri;
        movingRegistered=foo.data;
        centerFixed = size(fixedVolume)/2;
        centerFixed= round (centerFixed);
       
        
        f = figure('visible','off');
        subplot(1,3,1)
        imshowpair(movingRegistered(:,:,centerFixed(3)), fixedVolume(:,:,centerFixed(3)));
        subplot(1,3,2)
        imshowpair(squeeze(movingRegistered(:,centerFixed(2),:)), squeeze(fixedVolume(:,centerFixed(2),:)));
        subplot(1,3,3)
        imshowpair(squeeze(movingRegistered(centerFixed(1),:,:)), squeeze(fixedVolume(centerFixed(1),:,:)));
        title(['Axial Slice of Registered Volume of %s', fn]);
        saveas(f, sprintf('/Users/n.y.r/Desktop/Aging/ResultCompareSim/%s.png',fn))
        
        
    end
end

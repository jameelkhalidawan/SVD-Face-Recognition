% script computes the mean image of the given database...
% It reads the database images listed in the file one by
function [im]=meanImage

fid=fopen('./dataset/images-original.txt','r');
cwd=pwd;
limages=textscan(fid,'%s\n');
limages=limages{1};
mim=[];
for k=1:length(limages)
    im=imread([cwd './dataset/' limages{k}]); 
        if k==1
            mim=double(im);
        else
            mim=double(im)+mim;
        end
      
end

im=mim./length(limages);

figure,imshow(im,[]),title('Mean Image of Database');
end
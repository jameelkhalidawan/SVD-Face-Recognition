function [trainMat,testMat, trainLabel, testLabel,irows,icols]=readDatabase
% function reads the database and returns the data split in two matrices
% referred as trainMat and testMat.

% trainMat will be used to learn SVD or (will serve as Naive Reference matrix),
% whereas testMat rows will serve
% as our queries to test how well our system performs

%trainLabel will provide us the Id of person to which image belongs, similarly
%testLabel will provide us the Id of person we are testing...

%---------------------------------------------------------------
% Remember in the given database there are 15 subjects and each subject has 11 images.
% We will use each person 4 images for testing purposes and remaining
% 7 images for training purposes (serve as database) to learn the SVD.

% We will store each image as a row of the database matrix, we will also use label
% vectors to store the id (label) of each person, so the total dimensions of the database matrix will
% be (number of images) X (number-of-pixels-in-each-image );




%Open List file
fid=fopen('./dataset/images-original.txt','r');
cwd=pwd;
limages=textscan(fid,'%s\n');
limages=limages{1};


%Allocate Memory
im=imread([cwd './dataset/' limages{1}]); % 
irows=size(im,1); % each image rows and columns
icols=size(im,2);
% create a big matrix to load the complete database...
%
trainMat=zeros(15*7,irows*icols); % rows= number of images, columns = # of pixels
trainLabel=zeros(1,15*7); % to store the training labels...
testMat=zeros(15*4,irows*icols); % rows= number of images, columns = # of pixels
testLabel=zeros(1,15*   4); % to store the testing labels...

%Read the images in respective containers...
imid=1;
testcount=1;
traincount=1;
count=1;
for k=1:length(limages) % iterate over list of images
    im=imread([cwd './dataset/' limages{k}]); % read the image..
    disp(9898989); 
    disp(testcount);
    disp(traincount);
    disp(count);
    %the code to populate the  the  trainMat,testMat, testLabel,trainLabel, ...
     
    image = im(:);
        
    image = image';
    
    if( mod(k,11) >= 1 &&  mod(k,11) <=4 )
    
     testMat(testcount,:) = image;
     
     
     testLabel(1,testcount) = imid;
     
     testcount = testcount + 1;

    else
        
     trainMat(traincount,:) = image;
     
     
     trainLabel(1,traincount) = imid;
     
     traincount = traincount + 1;
    end
    
    if mod(k,11) == 0
        imid= imid+1  % id of person will change after eleven images...
    
         
    end
    
end


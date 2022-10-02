
% first read the database (both training and testing...)...
% test the accuracy of the system...

[trainMat,testMat, trainLabel, testLabel,rows,cols]=readDatabase;

queryImages = testMat';

databaseImages = trainMat';
n = size(testMat)
pause



%train SVD labels...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meanImg=meanImage;
meanImg=meanImg(:);
meanImg=double(meanImg);

db = zeros( size(databaseImages,1) , size(databaseImages,2));
for i=1:size(databaseImages,2)
db(:,i) = databaseImages(:,i) - meanImg; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U,S,V] = svd(db,'econ');

A=(S>0);
sumTotalSigmaValues = sum(S(:));

A=zeros(size(S,1) , size(S,1));

count =1;
A(:,count) = S(:,count);
sumCurrSigmaValues = sum(A(:));
while (sumCurrSigmaValues/sumTotalSigmaValues) * 100 < 95
    
    count = count+1;
    A(:,count) = S(:,count);
    sumCurrSigmaValues = sum(A(:));
end
count=count

W=U(:,1:count);
W=W';

queryImagest=zeros(count,size(queryImages,2));

for i=1:size(queryImages,2)
    queryImagest(:,i) = W*queryImages(:,i);
end

databaseImagest=zeros(count,size(databaseImages,2));

for i=1:size(databaseImages,2);
        databaseImagest(:,i) = W*databaseImages(:,i);
end




result = zeros( size(queryImagest,2), size(databaseImagest,2) ); % query image distance from database image 


for qImage=1:size(queryImagest,2)

     q1 = queryImagest(:,qImage);
    
         for dImage=1:size(databaseImagest,2)
    
             d1 = databaseImagest(:,dImage);
             
             
    
             distance = sum((q1 - d1).^ 2,1).^0.5;
             
             result(qImage,dImage) = distance;

         end

end



imageNo = 4  ; % query image used

% displaying query image 

im=queryImages(:,imageNo);

im=reshape(im,rows,cols);

im=uint8(im);

%figure;

%imshow(im);
figure,imshow(im,[]),title('query Image of Database');

% displaying closest database image
minDistance = min(result(imageNo,:));

index = find(result(imageNo,:) == minDistance);
    
    im = databaseImages(:,index);
    
    im=reshape(im,rows,cols);
    
    im=uint8(im);
    
    figure;
    
    imshow(im),title('database Image of Database');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% finding accuracy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
accuracy =0;
for imageNo = 1:size(queryImages,2)

    minDistance = min(result(imageNo,:));

    index = find(result(imageNo,:) == minDistance );


    if testLabel(1,imageNo ) == trainLabel(1,index)
        accuracy = accuracy + 1;
    end

end


accuracy = accuracy ./ size(testMat,1);
accuracy = accuracy* 100;
disp('The accuracy in percentage is: ');
accuracy




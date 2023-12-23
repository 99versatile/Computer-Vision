function contentAwareResize = generate_results(filename, reduceAmt, reduceWhat)
% read the image from filename
img = imread(filename);
% content
if strcmp(reduceWhat, 'HEIGHT')
    for i = 1:reduceAmt
        img = reduceHeight(img);
    end
else
    for i = 1:reduceAmt
        img = reduceWidth(img);
    end
end

contentAwareResize = img;
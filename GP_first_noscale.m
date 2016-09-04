clear all, close all
load('D:\Cynthia\project\new_data\poly2_signal90\problem01')

p = 25;
n = size(dat, 1);
mean_train = mean(dat(1:800,:));
maxmin = max(dat(1:800,:))-min(dat(1:800,:));
mean_m = ones(800,1)* mean_train;
maxmin_m = ones(800,1)*maxmin;
scaled = (dat(1:800,:)-mean_m)./maxmin_m;
X_dat = scaled(:, 26);
Z_dat = scaled(:, 1:25);
Y_dat = scaled(:, 27);
XZ_dat = scaled(:,1:26);

likfunc = @likGauss;
covfunc = {@covMaternard, 3}; 
hyp.cov = zeros(p + 2, 1); hyp.lik = log(0.1);
nlml = gp(hyp, @infExact, [], covfunc, likfunc,XZ_dat, Y_dat);

means = zeros(800,1);
for i = 1:800
XZ_matrix = [Z_dat X_dat(i) * ones(800, 1)];

[yhat , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix); % predict y for new data
means(i) = sum(yhat)/800;
end;
y_origin = means*(max(dat(1:800,27))-min(dat(1:800,27)))+mean_m(1:800,27);
mse_gp = sum((dat(1:800,27) - y_origin).^2)/800;
are_gp = sum((y_origin - dat(1:800,27))./dat(1:800,27))/800;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% testing
mean_test = mean(dat(801:1000,:));
maxmin_test = max(dat(801:1000,:))-min(dat(801:1000,:));
mean_m_test = ones(200,1)* mean_test;
maxmin_m_test = ones(200,1)*maxmin_test;
scaled_test = (dat(801:1000,:)-mean_m_test)./maxmin_m_test;
X_dat_test = scaled_test(:, 26);
Z_dat_test = scaled_test(:, 1:25);
Y_dat_test = scaled_test(:, 27);
XZ_dat_test = scaled_test(:,1:26);

means_test = zeros(200,1);
ys_test = zeros(200,1);
for i = 1:200
XZ_matrix_test = [Z_dat X_dat_test(i) * ones(800, 1)];

[yhat_test , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix_test); % predict y for new data
means_test(i) = sum(yhat_test)/800;
ys_test(i) = sum(ys2)/800;
end;
y_origin_test = means_test.*maxmin_m_test(:,27) + mean_m_test(:,27);

plot(dat(801:1000,26),y_origin_test,'+')
hold on; plot(dat(801:1000,26),dat(801:1000,28),'.')
csvwrite('D:\Cynthia\project\GPresult.csv',y_origin_test);






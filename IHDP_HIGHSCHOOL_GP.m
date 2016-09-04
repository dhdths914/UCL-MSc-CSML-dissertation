clear all, close all
load('D:\Cynthia\project\all_code\ihdp_ting_ya.mat')

p = 17;
n = size(train_dat{1}, 1);
mean_train = mean(train_dat{1});
maxmin = max(train_dat{1})-min(train_dat{1});
mean_m = ones(243,1)* mean_train;
maxmin_m = ones(243,1)*maxmin;
scaled = (train_dat{1}-mean_m)./maxmin_m;
X_dat = scaled(:, 2);
Z_dat = scaled(:, 3:19);
Y_dat = scaled(:, 1);
XZ_dat = scaled(:,2:19);

likfunc = @likGauss;
covfunc = {@covMaternard, 3}; 
hyp.cov = zeros(p + 2, 1); hyp.lik = log(0.1);
nlml = gp(hyp, @infExact, [], covfunc, likfunc,XZ_dat, Y_dat);

means = zeros(243,1);
for i = 1:243
XZ_matrix = [X_dat(i) * ones(243, 1) Z_dat];

[yhat , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix); % predict y for new data
means(i) = sum(yhat)/243;
end;
y_origin = means*(max(train_dat{1}(:,1))-min(train_dat{1}(:,1)))+mean(train_dat{1}(:,1));
% mse_gp = sum((dat(1:800,27) - y_origin).^2)/347;
% are_gp = sum((y_origin - dat(1:800,27))./dat(1:800,27))/347;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% testing
mean_test = mean(X_test{1});
maxmin_test = max(X_test{1})-min(X_test{1});
mean_m_test = ones(19,1)* mean_test;
maxmin_m_test = ones(19,1)*maxmin_test;
scaled_test = (X_test{1}-mean_m_test)./maxmin_m_test;
X_dat_test = scaled_test


means_test = zeros(19,1);
for i = 1:19
XZ_matrix_test = [X_dat_test(i) * ones(243, 1) Z_dat];

[yhat_test , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix_test); % predict y for new data
means_test(i) = sum(yhat_test)/243;
end;
y_origin_test = means_test.*maxmin_m_test + mean_m_test;

plot(X_test{3},Y_test{1},'.')
hold on; plot(X_test{1},y_origin_test,'+')
title('IHDP GP for High School Plot')
xlabel('treatment')
ylabel('outcome')

%csvwrite('D:\Cynthia\project\GPresult.csv',y_origin_test);

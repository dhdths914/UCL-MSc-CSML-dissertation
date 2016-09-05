clear all, close all
load('add your file path')

plot(train_dat{2}(:,2),train_dat{2}(:,1),'o')
title('Treatment and Outcomes of IHDP College Data Plot')
xlabel('treatment')
ylabel('outcome')

p = 18;
n = size(train_dat{2}, 1);
mean_train = mean(train_dat{2});
maxmin = max(train_dat{3})-min(train_dat{2});
mean_m = ones(104,1)* mean_train;
maxmin_m = ones(104,1)*maxmin;
scaled = (train_dat{2}-mean_m)./maxmin_m;
X_dat = scaled(:, 2);
Z_dat = scaled(:, 3:20);
Y_dat = scaled(:, 1);
XZ_dat = scaled(:,2:20);

likfunc = @likGauss;
covfunc = {@covMaternard, 3}; 
hyp.cov = zeros(p + 2, 1); hyp.lik = log(0.1);
nlml = gp(hyp, @infExact, [], covfunc, likfunc,XZ_dat, Y_dat);

means = zeros(104,1);
for i = 1:104
XZ_matrix = [X_dat(i) * ones(104, 1) Z_dat];

[yhat , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix); % predict y for new data
means(i) = sum(yhat)/104;
end;
y_origin = means*(max(train_dat{2}(:,1))-min(train_dat{2}(:,1)))+mean(train_dat{2}(:,1));
mse_gp = sum((train_dat{2}(:,1) - y_origin).^2)/104;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% testing
mean_test = mean(X_test{2});
maxmin_test = max(X_test{2})-min(X_test{2});
mean_m_test = ones(19,1)* mean_test;
maxmin_m_test = ones(19,1)*maxmin_test;
scaled_test = (X_test{2}-mean_m_test)./maxmin_m_test;
X_dat_test = scaled_test


means_test = zeros(19,1);
for i = 1:19
XZ_matrix_test = [X_dat_test(i) * ones(104, 1) Z_dat];

[yhat_test , ys2] = gp(hyp, @infExact, [], covfunc, likfunc, XZ_dat, Y_dat, XZ_matrix_test); % predict y for new data
means_test(i) = sum(yhat_test)/104;
end;
y_origin_test = means_test.*maxmin_m_test + mean_m_test;
mse_gp_test = sum((Y_test{2} - y_origin_test).^2)/19;



plot(X_test{2},Y_test{2},'.')
hold on; plot(X_test{2},y_origin_test,'+')
title('IHDP GP for College Plot')
xlabel('treatment')
ylabel('outcome')


csvwrite('D:\Cynthia\project\new_data\GPresult_IHDP\GP_IHDP_college_results.csv',y_origin_test);

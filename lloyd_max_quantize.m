%% Lloyd-Max量子化
% param
%    - sigma 正規分布の標準偏差
%    - x     量子化により表現される値(?)
%    - t     閾値

function [x,t] = lloyd_max_quantize(sigma)
    % 初期化
    x = [-1,-0.25,0.25,1];
    t = [ 1/2*(x(1)+x(2)), 1/2*(x(2)+x(3)), 1/2*(x(3)+x(4))];
    
    num = @(y) y .* normal_dist(y,sigma);
    den = @(y) normal_dist(y,sigma);
    
    for i=1:1:100
        x(1) = integral(num,-Inf,t(1))/integral(den,-Inf,t(1));
        x(2) = integral(num,t(1),t(2))/integral(den,t(1),t(2));
        x(3) = integral(num,t(2),t(3))/integral(den,t(2),t(3));
        x(4) = integral(num,t(3),Inf)/integral(den,t(3),Inf);
    
        t = [ 1/2*(x(1)+x(2)), 1/2*(x(2)+x(3)), 1/2*(x(3)+x(4))]; 
    end
end


%% 平均0の正規分布生成
function y = normal_dist(x,sigma)
    y = 1/(sqrt(2*pi)*sigma) * exp(-x.^2 /(2*sigma^2));
end
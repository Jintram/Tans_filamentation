


%% Simple statistics

% Formulae from:
% https://en.wikipedia.org/wiki/Binomial_distribution

% 180 vs. 108 
% Or 108/288 successes assuming 1/3 probability
% TODO: check in which script these numbers are determined.

k=[1:288];
n=288;
p=1/3;

nOverk = arrayfun(@(k) nchoosek(n,k),k);
%nOverk = factorial(n)./(factorial(k)-factorial(n-k)); % fails due inf
P = nOverk.*p.^k.*(1-p).^(n-k);

figure; clf;
plot(k,P);

figure; clf;
plot(k,cumsum(P));

hypothesisChance = sum(P(1:108))



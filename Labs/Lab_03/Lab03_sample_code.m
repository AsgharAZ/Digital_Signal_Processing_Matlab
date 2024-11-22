clc;clear;close all
A = 1;
J = 50;
M = 10;
L = 20000;
PSD = 0;
T = 1; Ts=T/M; fs=1/Ts;
for jj=1:L
sNt = [];
Bits = (sign(randn(1,2*J+1))+1)/2;
    for ii=1:2*J+1
        if Bits(ii)==1
            sNt=[A*ones(1,M) sNt];
        else
            sNt=[-A*ones(1,M) sNt];
        end
    end
    PSD = PSD + abs(fft(sNt)).^2;
end
PSD = PSD/L/(2*J+1)/T; 
LPSD = length(PSD);
figure(1); plot(PSD,'k-','linewidth',1.5)
set(gca,'FontSize',14);axis tight;grid on;
xlabel('$0\le k\le (2J+1)M$','FontSize',16,'interpreter','latex')
title('PSD (Unnormalized) vs. index $k$','FontSize',14,'interpreter','latex')
ylabel('$\Psi_s[k]$','FontSize',16,'interpreter','latex');
h=text(400,50,['$J = ' num2str(J) ', M = ' num2str(M) '$']);
set(h,'fontsize',14,'interpreter','latex');drawnow

DTFT_xaxis = linspace(0,2*pi,LPSD);
figure(2);plot(DTFT_xaxis,PSD,'k-','linewidth',1.5)
set(gca,'FontSize',14);axis tight; grid on;
xlabel('$0 \le \Omega\le 2\pi$ [radian]','FontSize',16,'interpreter','latex')
title('PSD (Unnormalized) vs. $\Omega$','FontSize',14,'interpreter','latex')
ylabel('$\Psi_s(\Omega)$','FontSize',16,'interpreter','latex');drawnow

fT = linspace(-T*fs/2,T*fs/2,LPSD); % normalized freq axis 
Area = sum(PSD)*(fT(2)-fT(1));
CTFT_PSD = PSD/Area; % normalized PSD
CTFT_PSD = [fliplr(CTFT_PSD(end:-1:floor(LPSD/2)))...
    CTFT_PSD(1:floor(LPSD/2)-1)];
figure(3);plot(fT,CTFT_PSD,'k-','linewidth',1.5)
set(gca,'FontSize',14);axis tight; grid on;
xlabel('$-Tf_s\,/\,2 \le Tf\le Tf_s\,/\,2$','FontSize',16,'interpreter','latex')
ylabel('$\Psi_s(f)$','FontSize',16,'interpreter','latex');
xlim([-fs/2 fs/2]);title('PSD vs. $Tf$ [Normalized and two-sided]',...
    'FontSize',14,'interpreter','latex');drawnow

figure(4);semilogy(fT,CTFT_PSD,'k-','linewidth',1.5);
set(gca,'FontSize',14);axis tight; grid on;
xlabel('$-Tf_s\,/\,2 \le Tf\le Tf_s\,/\,2$','FontSize',16,'interpreter','latex')
ylabel('$\Psi_s(f)$ [dB]','FontSize',16,'interpreter','latex');ylim([1e-3 1]);
xlim(T*[-fs/2 fs/2]);title('Log PSD vs. $Tf$ [Normalized and two-sided]',...
    'FontSize',14,'interpreter','latex');drawnow

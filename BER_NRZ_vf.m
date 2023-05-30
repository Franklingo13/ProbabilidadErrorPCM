%
% Comunicaciones Digitales  
% P5 Probabilidad de Error en PCM
% Autores: Flores Andres, Gomez Franklin, Otavalo David, Zaruma Samantha.
%
%
clc
clear all
close all

Nbit= input('ingrese el numero de bits: ');
%generacion de bits codificados
secBits = randi([0 1], 1, Nbit);
A = input('ingrese la amplitud:');
bits=A.*secBits; %secuencia de bits
Tb=input('ingrese el tiempo del bit (s): ');
RB=1/Tb; %tasa de Tx
T = length(secBits)/RB;
n = 100; %numero de puntos de muestra para cada bit
N = n*length(secBits);
dt = T/N;

t = 0:dt:T;%vector de tiempos
%vectores auxiliares para graficar signals
x = zeros (1, length (t));
x_m = zeros (1, length (t));
x_rec = zeros (1, length (t));

umbral = 0; %umbral

%representar Bits y PNRZ en el tiempo  
for i=1:length(secBits)
  if secBits(i)==1
    x((i-1)*n+1:i*n) = A;%datos con senalizacion P-NRZ
     x1((i-1)*n+1:i*n) = A; %datos orignales
     nrz(i)=(A);%Señalizacion P-NRZ
  elseif secBits(i)==0  
       x((i-1)*n+1:i*n) = -A; %datos con senalizacion P-NRZ
       x1((i-1)*n+1:i*n) = 0; %datos orignales
       nrz(i)=(-A); %Señalizacion P-NRZ
  end
end

%%%%%%%%%%%%%  muestreo %%%%%%%%%%%%%%%%%%%%%%
%Calcular los tiempos correspondientes a cada bit
tiempos = Tb * (0:length(nrz)-1);
fsample= 4*(1/2*Tb); %Freq.muestreo
% Muestrear la señal cada fsample y visualizar.
t_sampled = 0:(1 / fsample):max(tiempos)-1 / fsample;
bits_sampled = interp1(tiempos, nrz, t_sampled, 'previous');

%%%%%%%%% Adicion de riudo gaussiano a 
% la señal para distintos niveles SNR %%%%%%%%%%%%

    for j = 0:1:14
     %ruido blanco gaussino  
     x_ruido = awgn(bits_sampled,j,'measured');
   
     
%************* reconstruccion de la señal ****************%

    % vector para guardar la suma de la señal en cada Tb
    for i=1:length(secBits)-1
        suma(i)=(sum(x_ruido((i-1)*fsample+1:i*fsample)));
    end
    %x_m => señal filtrada
    for i=1:length(suma)
       x_m((i-1)*n+1:i*n) = suma(i)/fsample;
    end
    
    % dispositivo de desicion  
    secBits_rec = suma/fsample > umbral;

    %x_rec => señal reconstruida
    for i=1:length(suma)
       x_rec((i-1)*n+1:i*n) = secBits_rec(i)*A;
    end
    
    %Calculo cantidad de errores
    error = 0;
    for i=1:length(secBits)-1
        if secBits(i)~=secBits_rec(i)
            error=error+1;
        end
    end
    k=j+1;
    %Calculp BER
    Perror(k)=error/length(secBits_rec);
   
    %disp('el BER medido es: ');
    %disp(Perror);
    
    %Calculo BER teorico
    BER_teorico(k) = 0.5*erfc(sqrt(10^(j/10)));
    
    %disp('el BER teorico es: ');
    %disp(BER_teorico);
    end 

    % se grafican las diferentes señales
    % se limita el eje horizontal para 
    % observar mejor las señales
subplot(5,1,1);
    plot(t(1:end-1), x1,'k', 'Linewidth', 3);
    title('Datos originales');
    xlim([0 50])
subplot(5,1,2);
    plot(t, x, 'Linewidth', 3);
    title('Datos codificados en P-NRZ');
    xlim([0 50])
subplot(5,1,3);
    plot(t_sampled, x_ruido,'k', 'Linewidth', 3);
    title('Señal con Ruido');
    xlim([0 50])
subplot(5,1,4);
    plot(t(1:end),  x_m,'k', 'Linewidth', 3);
    title('Señal filtrada');
    xlim([0 50])
subplot(5,1,5);
    plot(t(1:end),  x_rec,'k', 'Linewidth', 3);
    title('Señal Recostruida');
    xlim([0 50])
    
    
    % se grafica BER vs Probabilidad de error
    figure(3);
    % Definir un rango de valores de SNR en dB
    SNR_dB = -2:1:16;
    %SNR_dB2 = -2:1:30;
    % Convertir de dB a escala lineal
    SNR_lineal = 10.^(SNR_dB/10);
    %SNR_lineal2 = 10.^(SNR_dB2/10);
    % Calcular el error teorico
    BER_teorico_graph = 0.5*erfc(sqrt(SNR_lineal));
    BER_teoricoUNRZ= qfunc(sqrt(SNR_lineal));
    BER_teoricoPRZ= qfunc(sqrt(2*SNR_lineal));
    
    % Graficar
    semilogy(SNR_dB,BER_teorico_graph,'r', 'Linewidth', 3);
    %hold on;
    title('BER vs SNR');
    xlabel('SNR (dB)');
    ylabel('BER');
    %grid on;
    hold on;
    %Grafica de los valores calculados de P.e
    semilogy(SNR_dB(3:end-2),Perror,'xk', 'Linewidth', 2);
    semilogy(SNR_dB,BER_teoricoUNRZ,'--b', 'Linewidth', 1.5);
    semilogy(SNR_dB,BER_teoricoPRZ,'--g', 'Linewidth', 1.5);
    legend('PNRZ teorico','PNRZ calculado','UNRZ  teorico','PRZ toerico')
    ylim([10^-12,0.2]) %limites en BER
    %legend('PNRZ teorico','PNRZ calculado')
    hold off;
     
    
   
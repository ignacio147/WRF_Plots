
XLAT =ncread('tiempo1','XLAT'); %latitud (sur negativo)
XLONG=ncread('tiempo1','XLONG'); %longitud (oeste negativo)
XLAT=double(XLAT);
XLAT=squeeze(XLAT(:,:,1));
XLONG=double(XLONG);
XLONG=squeeze(XLONG(:,1,:));
lat=XLAT(1,:)';
lon=XLONG(:,1);

data=ncread('tiempo1','T2');

T_1=data(:,:,73)-273.15
T2_00=T_1'




M = min(T2_00,[],2)
a=min(M)
N = max(T2_00,[],2)
b=max(N)


figure(1)
pcolor(lon,lat,T2_00)
title('T2 modelo +72 UTC','Fontsize',16)
xlabel('Longitud','Fontsize',16)
ylabel('Latitud','Fontsize',16)
colormap(jet)
set(gca,'Fontsize',20,'Linewidth',2)
shading interp
c=colorbar
c.Label.String = 'Temperatura °C';
caxis([-10 20])
axis tight
box off



datau=ncread('tiempo1','U10' );
datav=ncread('tiempo1','V10' );

%V = sqrt(u^2+v^2) 



for i=1:99;
    for j=1:99;
        for z=1:385;
        W(i,j,z)=sqrt((datau(i,j,z).^2)+(datav(i,j,z).^2));
        end
    end

end

for i=1:99;
    for j=1:99;
        W_pro(i,j)=mean(W(i,j,:));
        
    end

end


figure(1)
pcolor(lon,lat,W_pro')
title('Viento a 10m','Fontsize',16)
xlabel('Longitud','Fontsize',16)
ylabel('Latitud','Fontsize',16)
% cmocean('phase')
colormap(jet)
set(gca,'Fontsize',20,'Linewidth',2)
shading interp
c=colorbar
c.Label.String = 'Viento m/s';
% caxis([-10 20])
axis tight
box off



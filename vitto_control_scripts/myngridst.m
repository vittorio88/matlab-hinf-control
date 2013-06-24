% Versione da fornire agli studenti 

function [] = myngridst(Tpo,Sro)

status = ishold;
limit=axis;
if nargin == 1 | nargin == 2
  %hold off
else
  axis(axis)
  hold on
  if limit(3) >= 0,
    disp('This is not a Nichols Chart. Use ngrid(''new'') for new Nichols Chart grid');
    hold off
    return
  end;
end
if nargin == 1
   Sro=1e6;
end

% Genera il vettore per l'asse delle ascisse (fase)
px=linspace(-359.99,-0.01,500);

% Definisce unità immaginaria
i = sqrt(-1);

% Dominio
[p,m] = meshgrid(px,Tpo);
[p,s] = meshgrid(px,Sro);

% Definisce il generico numero complesso con fase p e modulo m
z = m .*exp(i*p/180*pi);

% Definisce il generico numero complesso con fase p e modulo s
z1=s .*exp(i*p/180*pi);


g = z./(1-z);
g1=(1-z1)./z1;
gain = 20*log10(abs(g));
gain1 = 20*log10(abs(g1));

% Riconduce la fase tra 0 e -360
phase = rem(angle(g)/pi*180+360,360)-360;
phase1 = rem(angle(g1)/pi*180+360,360)-360;

% Disegna le curve a modulo costante
plot(phase',gain','-b');
hold on
plot(phase1',gain1','-b');

% Impone i limiti per gli assi
if nargin == 1 | nargin == 2
	set(gca,'xlim',[-360, 0]);
	set(gca,'ylim',[-50, 50]);
end

plot([-180 -180],[-100 100],'b--')
plot([-360 0],[0 0],'b--')

if (nargin==0) & (~status), hold off, end	    % Return hold to previous status
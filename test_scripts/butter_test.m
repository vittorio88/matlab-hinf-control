
Wp=S.design.bandwidth/10e3
Ws=dp.values.frequency/10e3
Rp=S.design.p.db
Rs=Ms_lf.db


[n,Wn] = buttord(Wp,Ws,Rp,Rs)
[b,a]  = butter(n,Wn,'high')
bode(tf(b,a))

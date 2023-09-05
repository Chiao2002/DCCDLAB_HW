function sort_out = sort4(a, b, c, d)
[x, y] = paral_comp(a,b);
[z, w] = paral_comp(c,d);
[min, u] = paral_comp(x,z);
[v, max] = paral_comp(y,w);
[sec, thr] = paral_comp(u,v);
sort_out = [min sec thr max];
end


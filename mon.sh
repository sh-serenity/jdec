ssh 185.151.247.137 systemctl restart ceph-mon@j1
ssh 185.151.247.138 systemctl restart ceph-mon@j2
ssh 185.151.247.139 systemctl restart ceph-mon@j3
ssh 185.151.247.137 systemctl restart ceph-mgr@j1
ssh 185.151.247.138 systemctl restart ceph-mgr@j2
ssh 185.151.247.139 systemctl restart ceph-mgr@j3

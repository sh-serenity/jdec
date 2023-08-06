mkdir -p /mnt/$1//sys/fs/cgroup
mkdir -p /mnt/$1/sys/fs/cgroup/cpu,cpuacct
mount -t cgroup -o cpu,cpuacct none /mnt/$1/sys/fs/cgroup/cpu,cpuacct
mkdir /mnt/$1/sys/fs/cgroup/cpuset
mount -t cgroup -o cpuset none /mnt/$1/sys/fs/cgroup/cpuset
mkdir /mnt/$1/sys/fs/cgroup/memory
mount -t cgroup -o memory none /mnt/$1/sys/fs/cgroup/memory
mkdir /mnt/$1/sys/fs/cgroup/devices
mount -t cgroup -o devices none /mnt/$1/sys/fs/cgroup/memory
mkdir /mnt/$1/sys/fs/cgroup/freezer
mount -t cgroup -o freezer none /mnt/$1/sys/fs/cgroup/freezer
mkdir /mnt/$1/sys/fs/cgroup/net_cls
mount -t cgroup -o net_cls none /mnt/$1/sys/fs/cgroup/net_cls
mkdir /mnt/$1/sys/fs/cgroup/blkio
mount -t cgroup -o blkio none /mnt/$1/sys/fs/cgroup/blkio
mkdir /mnt/$1/sys/fs/cgroup/perf_event
mount -t cgroup -o perf_event none /mnt/$1/sys/fs/cgroup/perf_event
mkdir /mnt/$1/sys/fs/cgroup/net_prio
mount -t cgroup -o blkio none /mnt/$1/sys/fs/cgroup/net_prio

mkdir /mnt/$1/sys/fs/cgroup/hugetlb
mount -t cgroup -o blkio none /mnt/$1/sys/fs/cgroup/hugetlb


mkdir /mnt/$1/sys/fs/cgroup/pids
mount -t cgroup -o blkio none /mnt/$1/sys/fs/cgroup/pids


mkdir /mnt/$1/sys/fs/cgroup/rdma
mount -t cgroup -o blkio none /mnt/$1/sys/fs/cgroup/rdma


cmd_/home/xiongxin/Data/Code/playground/linux/lkmpg/hello/modules.order := {   echo /home/xiongxin/Data/Code/playground/linux/lkmpg/hello/hello-5.ko; :; } | awk '!x[$$0]++' - > /home/xiongxin/Data/Code/playground/linux/lkmpg/hello/modules.order
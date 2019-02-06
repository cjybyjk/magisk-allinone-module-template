# 引入额外函数支持
INSTALLER="$2"
source $INSTALLER/common/util_functions.sh
MODFILEDIR="$INSTALLER/common/$1/files"
MODPATH="$3"

ui_print "您已按下[音量-]"

mkdir -p $MODPATH/system/app/
cp -r $MODFILEDIR/system/app/testapp2 $MODPATH/system/app/

# 附加值到 system.prop
add_sysprop "ro.a.b=2"
# 从文件附加值到 system.prop
add_sysprop_file $MODFILEDIR/system2.prop
# 添加service.sh
add_service_sh $MODFILEDIR/service2.sh
# 添加post-fs-data.sh
add_post-fs-data_sh $MODFILEDIR/post-fs-data2.sh

ui_print "设置权限"
set_perm_recursive  $MODPATH  0  0  0755  0644
# 只有一些特殊文件需要特定的权限

# 下面是 set_perm 函数的一些示例:

# set_perm_recursive  <目录>                <所有者> <用户组> <目录权限> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
# set_perm_recursive  $MODPATH/system/lib       0       0       0755        0644

# set_perm  <文件名>                         <所有者> <用户组> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
# set_perm  $MODPATH/system/bin/app_process32   0       2000      0755       u:object_r:zygote_exec:s0
# set_perm  $MODPATH/system/bin/dex2oat         0       2000      0755       u:object_r:dex2oat_exec:s0
# set_perm  $MODPATH/system/lib/libart.so       0       0         0644


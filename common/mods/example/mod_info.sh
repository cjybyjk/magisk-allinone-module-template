mod_name="测试模板"
mod_install_info="是否安装$mod_name"
# mod_install_info="是否启用xx功能"
mod_yes_text="安装$mod_name"
mod_no_text="不安装$mod_name"
require_device="cancro"
# 支持正则表达式
#require_device="cancro|shamu|viper"
require_version="7.1.2"
# 支持正则表达式
#require_version="7\.[0-1]\.[0-2]" #(7.0.0-7.1.2)

# 按下[音量+]时执行
# 如果不需要，请保留函数结构和return 0
mod_install_yes()
{
    mkdir -p $MODPATH/system/app/
    cp -r $MODFILEDIR/system/app/testapp1 $MODPATH/system/app/

    # 附加值到 system.prop
    add_sysprop "ro.a.b=1"
    # 从文件附加值到 system.prop
    add_sysprop_file $MODFILEDIR/system1.prop
    # 添加service.sh
    add_service_sh $MODFILEDIR/service1.sh
    # 添加post-fs-data.sh
    add_postfsdata_sh $MODFILEDIR/post-fs-data1.sh

    ui_print "设置权限"
    set_perm_recursive  $MODPATH  0  0  0755  0644
    
    return 0
}

# 按下[音量-]时执行
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
    mkdir -p $MODPATH/system/app/
    cp -r $MODFILEDIR/system/app/testapp2 $MODPATH/system/app/

    # 附加值到 system.prop
    add_sysprop "ro.a.b=2"
    # 从文件附加值到 system.prop
    add_sysprop_file $MODFILEDIR/system2.prop
    # 添加service.sh
    add_service_sh $MODFILEDIR/service2.sh
    # 添加post-fs-data.sh
    add_postfsdata_sh $MODFILEDIR/post-fs-data2.sh

    ui_print "设置权限"
    set_perm_recursive  $MODPATH  0  0  0755  0644
    
    return 0
}

# 对权限的附加说明
# 只有一些特殊文件需要特定的权限
# 下面是 set_perm 函数的一些示例:

# set_perm_recursive  <目录>                <所有者> <用户组> <目录权限> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
# set_perm_recursive  $MODPATH/system/lib       0       0       0755        0644

# set_perm  <文件名>                         <所有者> <用户组> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
# set_perm  $MODPATH/system/bin/app_process32   0       2000      0755       u:object_r:zygote_exec:s0
# set_perm  $MODPATH/system/bin/dex2oat         0       2000      0755       u:object_r:dex2oat_exec:s0
# set_perm  $MODPATH/system/lib/libart.so       0       0         0644


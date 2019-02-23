# 安装时显示的模块名称
mod_name="测试模板"
# 安装时显示的提示
mod_install_info="是否安装$mod_name"
# 按下[音量+]选择的功能提示
mod_select_yes_text="安装$mod_name"
# 按下[音量+]后加入module.prop的内容
mod_select_yes_desc="[$mod_select_yes_text]"
# 按下[音量-]选择的功能提示
mod_select_no_text="不安装$mod_name"
# 按下[音量-]后加入module.prop的内容
mod_select_no_desc=""
# 支持的设备，支持正则表达式
mod_require_device="cancro|shamu|viper|keyaki_dsds"
# 支持的系统版本，持正则表达式
mod_require_version="7.[0-1].[0-2]" #(7.0.0-7.1.2)

if [ "`check_mod_install ''`" = "yes" ]; then
    # 已经安装过 example
    ui_print "    已经安装过example了，跳过安装？"
    ui_print "   [音量+]：yes"
    ui_print "   [音量-]：no"
    # 进行音量键选择
    if $VOLKEY_FUNC ; then
        MOD_SKIP_INSTALL=true
    fi
fi

# 按下[音量+]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_yes()
{
    mkdir -p $MODPATH/system/app/
    cp -r $MOD_FILES_DIR/system/app/testapp1 $MODPATH/system/app/

    # 附加值到 system.prop
    add_sysprop "ro.a.b=1"
    # 从文件附加值到 system.prop
    add_sysprop_file $MOD_FILES_DIR/system1.prop
    # 添加service.sh
    add_service_sh $MOD_FILES_DIR/service1.sh
    # 添加post-fs-data.sh
    add_postfsdata_sh $MOD_FILES_DIR/post-fs-data1.sh

    ui_print "    设置权限"
    set_perm_recursive  $MODPATH  0  0  0755  0644
    
    return 0
}

# 按下[音量-]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
    mkdir -p $MODPATH/system/app/
    cp -r $MOD_FILES_DIR/system/app/testapp2 $MODPATH/system/app/

    # 附加值到 system.prop
    add_sysprop "ro.a.b=2"
    # 从文件附加值到 system.prop
    add_sysprop_file $MOD_FILES_DIR/system2.prop
    # 添加service.sh
    add_service_sh $MOD_FILES_DIR/service2.sh
    # 添加post-fs-data.sh
    add_postfsdata_sh $MOD_FILES_DIR/post-fs-data2.sh

    ui_print "    设置权限"
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


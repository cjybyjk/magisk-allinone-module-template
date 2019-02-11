### 多合一模块模板 使用指引

#### Step 1：修改`config.sh`
- 将提示信息修改为你想要的格式
```bash
    ui_print "*******************************"
    ui_print "   Magisk多合一模块示例   "
    ui_print "*******************************"
```
- 如果你想要获取MIUI版本，将
    ```bash 
        var_version="`grep_prop ro.build.version.release`"
    ```
    改为
    ```bash
        var_version="`grep_prop ro.build.version.incremental`"
    ```
- 在测试完成后，请关闭调试开关：将 `DEBUG_FLAG=true` 改为 `DEBUG_FLAG=false`

#### Step 2：添加功能模块
- 所有的功能模块都需要放在 `common/mods/` 文件夹下
- 模板提供了 `common/mods/example` 和 `common/mods/empty` 作为参考
- 功能模块的目录格式：
    ```
        common/mods/
        ├── .
        │
        ├── $MOD                   <--- The folder is named with the ID of the module
        │   │
        │   ├── mod_info.sh        <--- Include the information of the module
        │   │
        │   ├── files              <--- Put files which will be used by the module here, it will be identified by the variable $MODFILEDIR 
        │   │   ├── .
        │   │   ├── .
        │   │   └── .
        │   │
        │   │      *** Others ***
        │   │
        │   ├── .                  <--- Any additional files / folders are allowed
        │   └── .
        │
        ├── another_mods
        │   ├── .
        │   └── .
        ├── .
    ```
- 将要用到的文件都放进 `common/mods/$MOD/files/`
- 创建 `common/mods/$MOD/mod_info.sh`
#### Step 3：编写 `mod_info.sh`
- 请参考 `common/mods/example/mod_info.sh` `common/mods/empty/mod_info.sh`

##### 变量说明
- 安装脚本会读取这几个变量，请修改它们以符合你的要求：
    ```bash
        # 安装时显示的模块名称
        mod_name="测试模板"
        # 安装时显示的提示
        mod_install_info="是否安装$mod_name"
        # 按下[音量+]选择的功能提示
        mod_yes_text="安装$mod_name"
        # 按下[音量+]后加入module.prop的内容
        mod_select_yes_desc="[$mod_yes_text]"
        # 按下[音量-]选择的功能提示
        mod_no_text="不安装$mod_name"
        # 按下[音量-]后加入module.prop的内容
        mod_select_no_desc=""
        # 支持的设备，支持正则表达式
        mod_require_device="cancro|shamu|viper|E6683"
        # 支持的系统版本，持正则表达式
        mod_require_version="7\.[0-1]\.[0-2]" #(7.0.0-7.1.2)
    ```
- `mod_info.sh` 与 `config.sh` 共享所有变量，如：
    ```bash
        $MODPATH #模块安装文件夹
        $INSTALLER # 安装程序目录
    ```
- $REPLACE 仍然可以用来替换文件夹
- $MODS_SELECTED_YES 包含选择了"yes"的模块(**由config.sh维护，请不要对它进行修改**)
- $MODS_SELECTED_NO 包含选择了"no"的模块(**由config.sh维护，请不要对它进行修改**)
- $MOD_SKIP_INSTALL 可以设置为true以跳过这个安装
- $INSTALLED_FUNC 已安装的功能 将显示在模块描述中

##### 函数说明
- mod_install_yes：这个函数将在用户选择 **[音量+]** 时被执行
    如果不需要执行任何动作，请将其替换为：
    ```bash
        mod_install_yes()
        {
            return 0
        }
    ```
- mod_install_no：这个函数将在用户选择 **[音量-]** 时被执行
    如果不需要执行任何动作，请将其替换为：
    ```bash
        mod_install_no()
        {
            return 0
        }
    ```
- `config.sh` 中提供了几个额外的功能函数
    - add_sysprop：添加键值到 `system.prop`
    - add_sysprop_file：将整个文件附加到 `system.prop` 后
    - add_service_sh：添加 `service.sh`
    - add_postfsdata_sh：添加 `post-fs-data.sh`
    - $VOLKEY_FUNC：用于音量键选择，**[音量+]** 返回`0`，**[音量-]** 返回`1`
    - check_mod_install：检查某个模块的安装状态，传入模块id，返回"yes"（选择 **[音量+]** ），"no"（选择 **[音量-]** ）或者"unknown"（还未安装）
    - trim：去除字符串首尾的空格
    - set_perm：设置权限
    - set_perm_recursive：设置权限（递归）
#### Step 4：打包
#### Step 5：安装以进行测试

#### 注意事项
- 请不要将 `common/mods/example/` 和 `common/mods/empty/` 留在正式版模块中
- 模块id需要符合这个正则表达式：`^[a-zA-Z][a-zA-Z0-9\._-]+$`

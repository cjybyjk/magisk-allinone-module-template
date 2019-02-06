# 这个文件为模块提供额外的函数支持

# 加载公用函数
if [ -f /data/adb/magisk/util_functions.sh ]; then
  . /data/adb/magisk/util_functions.sh
elif [ -f /data/magisk/util_functions.sh ]; then
  NVBASE=/data
  . /data/magisk/util_functions.sh
fi

# $1:prop_text
add_sysprop()
{
  echo "$1" >> $MODPATH/system.prop
}

# $1:path/to/file
add_sysprop_file()
{
  cat "$1" >> $MODPATH/system.prop
}

# $1:path/to/file
add_service_sh()
{
  cp "$1" $MODPATH/service_sh/
}

# $1:path/to/file
add_post-fs-data_sh()
{
  cp "$1" $MODPATH/post-fs-data_sh/
}
